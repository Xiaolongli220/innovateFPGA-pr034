#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "srcparam.h"
#include "calculate.h"
#include <math.h>
#include "opencl.h"
#include "aocl_utils.h"
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>
#include <sys/shm.h>


#define MYPORT  8000

using namespace aocl_utils;

// OpenCL runtime configuration
cl_platform_id platform = NULL;
unsigned num_devices = 0;
scoped_array<cl_device_id> device; // num_devices elements
cl_context context = NULL;
scoped_array<cl_command_queue> queue; // num_devices elements
cl_program program = NULL;
scoped_array<cl_kernel> kernel; // num_devices elements
scoped_array<cl_mem> input_a_buf; // num_devices elements
scoped_array<cl_mem> input_b_buf; // num_devices elements
scoped_array<cl_mem> output_buf; // num_devices elements

// Problem data.
const unsigned N = 1000000; // problem size
scoped_array<scoped_aligned_ptr<int> > input_a;
scoped_array<scoped_aligned_ptr<int> > input_b; // num_devices elements
scoped_array<scoped_aligned_ptr<int> > output; // num_devices elements
scoped_array<scoped_array<int> > ref_output; // num_devices elements
scoped_array<scoped_array<int> > ref_max;
scoped_array<unsigned> n_per_device; // num_devices elements

// Function prototypes
int rand_int();
bool init_opencl();
void init_problem(int flat[]);
void run();
void cleanup();

// Entry point.
int main() {

  // socket signal input
  int sock_cli;
  fd_set rfds;
  struct timeval tv;
  int retval, maxfd;
  int flat[4000];
  int *fflat[4000];
  int k;


  ///定义sockfd
  sock_cli = socket(AF_INET,SOCK_STREAM, 0);
    ///定义sockaddr_in
  struct sockaddr_in servaddr;
  memset(&servaddr, 0, sizeof(servaddr));
  servaddr.sin_family = AF_INET;
  servaddr.sin_port = htons(MYPORT);  ///服务器端口
  servaddr.sin_addr.s_addr = inet_addr("169.254.5.227");  ///服务器ip
    //连接服务器，成功返回0，错误返回-1
  while (connect(sock_cli, (struct sockaddr *)&servaddr, sizeof(servaddr)) < 0)
    {
      perror("connect");
      exit(1);
    }
    
  // Initialize OpenCL.
  if(!init_opencl()) {
    return -1;
  }

  while(1){
    //int maxa,maxi=0;
    //int mina=179;
    //int mini=179;
          
      //数组接收
    recv(sock_cli, (char *)&flat, sizeof(flat),0);
      //for(int i=0;i<4000;i++){
            //printf("%d\n", flat[i]);
        //}
      //close(sock_cli);
      
      // Initialize the problem data.
      // Requires the number of devices to be known.
    init_problem(flat);
      

      // Run the kernel
    run();
    
  }
  // Free the resources allocated
  cleanup();
  close(sock_cli);
  

  return 0;
}

/////// HELPER FUNCTIONS ///////

// Randomly generate a floating-point number between -10 and 10.
int rand_int() {
  return int(rand());
}

// Initializes the OpenCL objects.
bool init_opencl() {
  cl_int status;

 // printf("Initializing OpenCL\n");

  if(!setCwdToExeDir()) {
    return false;
  }

  // Get the OpenCL platform.
  platform = findPlatform("Intel(R) FPGA");
  if(platform == NULL) {
  //  printf("ERROR: Unable to find Intel(R) FPGA OpenCL platform.\n");
    return false;
  }

  // Query the available OpenCL device.
  device.reset(getDevices(platform, CL_DEVICE_TYPE_ALL, &num_devices));
  //printf("Platform: %s\n", getPlatformName(platform).c_str());
  //printf("Using %d device(s)\n", num_devices);
  for(unsigned i = 0; i < num_devices; ++i) {
   // printf("  %s\n", getDeviceName(device[i]).c_str());
  }

  // Create the context.
  context = clCreateContext(NULL, num_devices, device, NULL, NULL, &status);
  checkError(status, "Failed to create context");

  // Create the program for all device. Use the first device as the
  // representative device (assuming all device are of the same type).
  std::string binary_file = getBoardBinaryFile("calculate_double", device[0]);
  //printf("Using AOCX: %s\n", binary_file.c_str());
  program = createProgramFromBinary(context, binary_file.c_str(), device, num_devices);

  // Build the program that was just created.
  status = clBuildProgram(program, 0, NULL, "", NULL, NULL);
  checkError(status, "Failed to build program");

  // Create per-device objects.
  queue.reset(num_devices);
  kernel.reset(num_devices);
  n_per_device.reset(num_devices);
  input_a_buf.reset(num_devices);
  input_b_buf.reset(num_devices);
  output_buf.reset(num_devices);

  for(unsigned i = 0; i < num_devices; ++i) {
    // Command queue.
    queue[i] = clCreateCommandQueue(context, device[i], CL_QUEUE_PROFILING_ENABLE, &status);
    checkError(status, "Failed to create command queue");

    // Kernel.
    const char *kernel_name = "calculate_mini";
    kernel[i] = clCreateKernel(program, kernel_name, &status);
    checkError(status, "Failed to create kernel");

    // Determine the number of elements processed by this device.
    n_per_device[i] = N / num_devices; // number of elements handled by this device

    // Spread out the remainder of the elements over the first
    // N % num_devices.
    if(i < (N % num_devices)) {
      n_per_device[i]++;
    }

    // Input buffers.
    input_a_buf[i] = clCreateBuffer(context, CL_MEM_READ_ONLY, 
        4*180*180 * sizeof(int), NULL, &status);
    checkError(status, "Failed to create buffer for input A");

    input_b_buf[i] = clCreateBuffer(context, CL_MEM_READ_ONLY, 
        4*1000 * sizeof(int), NULL, &status);
    checkError(status, "Failed to create buffer for input B");

    // Output buffer.
    output_buf[i] = clCreateBuffer(context, CL_MEM_WRITE_ONLY, 
        2*180*180 * sizeof(int), NULL, &status);
    checkError(status, "Failed to create buffer for output");
  }

  return true;
}

// Initialize the data for the problem. Requires num_devices to be known.
void init_problem(int flat[]) {
  int signalmatrixA[4][1000];
  int source[4][180][180];
  sourceassign(source);
  for(int i=0;i<4;i++){
    for(int j=0;j<1000;j++){
       signalmatrixA[i][j] = flat[1000*i+j];
    }
  }
  

  if(num_devices == 0) {
    checkError(-1, "No devices");
  }

  input_a.reset(num_devices);
  input_b.reset(num_devices);
  output.reset(num_devices);
  //ref_output.reset(num_devices);
  ref_max.reset(num_devices);
  //ref_output.reset(num_devices);

  // Generate input vectors A and B and the reference output consisting
  // of a total of N elements.
  // We create separate arrays for each device so that each device has an
  // aligned buffer. 
  for(unsigned i = 0; i < num_devices; ++i) {
    input_a[i].reset(4*180*180);
    input_b[i].reset(4000);
    output[i].reset(2*180*180);
    //ref_output[i].reset(180*180);
    ref_max[i].reset(2);

    for(int j = 0; j < 4*180*180; ++j) {

        input_a[i][j] = source[j/32400][(j%32400)/180][(j%32400)%180];
      
    }
    
    for(int j = 0; j < 4*1000; ++j) {
        input_b[i][j] = signalmatrixA[j/1000][j%1000];
    }
    
  
  }
  
}

void run() {
  cl_int status;

  const double start_time = getCurrentTimestamp();

  // Launch the problem for each device.
  scoped_array<cl_event> kernel_event(num_devices);
  scoped_array<cl_event> finish_event(num_devices);

  for(unsigned i = 0; i < num_devices; ++i) {

    // Transfer inputs to each device. Each of the host buffers supplied to
    // clEnqueueWriteBuffer here is already aligned to ensure that DMA is used
    // for the host-to-device transfer.
    cl_event write_event[2];

    status = clEnqueueWriteBuffer(queue[i], input_a_buf[i], CL_FALSE,
        0, 4*180*180 * sizeof(int), input_a[i], 0, NULL, &write_event[0]);
    checkError(status, "Failed to transfer input A");

    status = clEnqueueWriteBuffer(queue[i], input_b_buf[i], CL_FALSE,
        0, 4000 * sizeof(int), input_b[i], 0, NULL, &write_event[1]);
    checkError(status, "Failed to transfer input B");

    // Set kernel arguments.
    unsigned argi = 0;

    status = clSetKernelArg(kernel[i], argi++, sizeof(cl_mem), &input_a_buf[i]);
    checkError(status, "Failed to set argument %d", argi - 1);

    status = clSetKernelArg(kernel[i], argi++, sizeof(cl_mem), &input_b_buf[i]);
    checkError(status, "Failed to set argument %d", argi - 1);

    status = clSetKernelArg(kernel[i], argi++, sizeof(cl_mem), &output_buf[i]);
    checkError(status, "Failed to set argument %d", argi - 1);

    // Enqueue kernel.
    // Use a global work size corresponding to the number of elements to add
    // for this device.
    // 
    // We don't specify a local work size and let the runtime choose
    // (it'll choose to use one work-group with the same size as the global
    // work-size).
    //
    // Events are used to ensure that the kernel is not launched until
    // the writes to the input buffers have completed.
    const size_t global_work_size = 180*180;
    //printf("Launching for device %d (%d elements)\n", i, global_work_size);

    status = clEnqueueNDRangeKernel(queue[i], kernel[i], 1, NULL,
        &global_work_size, NULL, 2, write_event, &kernel_event[i]);
    checkError(status, "Failed to launch kernel");

    // Read the result. This the final operation.
    status = clEnqueueReadBuffer(queue[i], output_buf[i], CL_FALSE,
        0, 2*180*180 * sizeof(int), output[i], 1, &kernel_event[i], &finish_event[i]);

    // Release local events.
    clReleaseEvent(write_event[0]);
    clReleaseEvent(write_event[1]);
  }

  // Wait for all devices to finish.
  clWaitForEvents(num_devices, finish_event);

  const double end_time = getCurrentTimestamp();

  // Wall-clock time taken.
 // printf("\nTime: %0.3f ms\n", (end_time - start_time) * 1e3);

  // Get kernel times using the OpenCL event profiling API.
  for(unsigned i = 0; i < num_devices; ++i) {
    cl_ulong time_ns = getStartEndTime(kernel_event[i]);
    //printf("Kernel time (device %d): %0.3f ms\n", i, double(time_ns) * 1e-6);
  }

  // Release all events.
  for(unsigned i = 0; i < num_devices; ++i) {
    clReleaseEvent(kernel_event[i]);
    clReleaseEvent(finish_event[i]);
  }

  // find maxtheta,maxphi
  for(unsigned i = 0; i < num_devices; ++i) {
    int max,maxx = 0;
    int maxtheta = 0;
    int maxphi = 1;
    ref_max[i][0] = 0;
    ref_max[i][1] = 1;
    for(unsigned int j = 0; j < 32400; ++j) {
      if(output[i][j] > max){
        max = output[i][j];
        maxtheta = j/180;
        maxphi = j%180;
      }
    }

    for(int j = 32400; j<2*180*180; ++j){
      if(output[i][j] > maxx){
        maxx = output[i][j];
        ref_max[i][0] = (j-180*180)/180;
        ref_max[i][1] = (j-180*180)%180;
      }
    }

    // Verify results.
    if(abs(maxtheta-ref_max[i][0])<10 && abs(maxphi-ref_max[i][1])<10){
      printf("%d %d\n",maxtheta,maxphi);
    }

  }

  
  
}

// Free the resources allocated during initialization
void cleanup() {
  for(unsigned i = 0; i < num_devices; ++i) {
    if(kernel && kernel[i]) {
      clReleaseKernel(kernel[i]);
    }
    if(queue && queue[i]) {
      clReleaseCommandQueue(queue[i]);
    }
    if(input_a_buf && input_a_buf[i]) {
      clReleaseMemObject(input_a_buf[i]);
    }
    if(input_b_buf && input_b_buf[i]) {
      clReleaseMemObject(input_b_buf[i]);
    }
    if(output_buf && output_buf[i]) {
      clReleaseMemObject(output_buf[i]);
    }
  }

  if(program) {
    clReleaseProgram(program);
  }
  if(context) {
    clReleaseContext(context);
  }
}

