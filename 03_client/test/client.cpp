#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/shm.h>
#include "calculate.h"
#include "srcparam.h"

#define MYPORT  8000
#define BUFFER_SIZE 1024
int main()
{
    int sock_cli;
    fd_set rfds;
    struct timeval tv;
    int retval, maxfd;

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


    while(1){
        int flat[4000];
        recv(sock_cli, (char *)&flat, sizeof(flat),0);
        int signalmatrixA[4][1000];
        int source[4][180][180];
        int A[2];
        int thetaphiA[180][180];
        sourceassign(source);
        for(int i=0;i<4;i++){
            for(int j=0;j<1000;j++){
                signalmatrixA[i][j] = flat[1000*i+j];
        }
        }
        calculate(source,signalmatrixA,thetaphiA,A);
         

    }
    
    
  
    close(sock_cli);
    return 0;
}