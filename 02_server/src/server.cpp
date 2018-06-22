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
#include <iostream>
#include "mman.h"
#define ALT_LWFPGASLVS_OFST 0xFF200000
#define signal1_BASE            0x3000
#define signal1_SPAN             0x10
#define signal2_BASE            0x7000
#define signal2_SPAN             0x10
#define signal3_BASE            0x8000
#define signal3_SPAN             0x10
#define signal4_BASE            0x9000
#define signal4_SPAN             0x10
#define rdaddr_BASE            0x4000
#define rdaddr_SPAN             0x0A
#define rden_BASE            0x5000
#define rden_SPAN             0x02
#define rready_BASE            0x6000
#define rready_SPAN             0x01
#define q_SPAN             0x01
#define q_BASE             0x0000
#define PORT 8000
#define QUEUE 20

int main() {
    unsigned long *signal1;
    unsigned long *rdaddr;
    unsigned long *rden;
    unsigned long *rready;
    unsigned long *signal2;
    unsigned long *signal3;
    unsigned long *signal4;
    unsigned long *q;
    int signum=2;
    int sig[4][1000];
    int fd;
    

//以下是服务器的信号传输部分
    fd_set rfds;
    struct timeval tv;
    int retval, maxfd;     //选择器


        /*创建socket*/
    int ss = socket(AF_INET, SOCK_STREAM, 0);   //AF_INET   IPV4   ;SOCK_STREAM   TCP
    struct sockaddr_in server_sockaddr;
    server_sockaddr.sin_family = AF_INET;
    server_sockaddr.sin_port = htons(PORT);
    server_sockaddr.sin_addr.s_addr = htonl(INADDR_ANY);

    /*bind*/
    if(bind(ss, (struct sockaddr* ) &server_sockaddr, sizeof(server_sockaddr))==-1) {
        perror("bind");
        exit(1);
    }
    /*listen*/
    if(listen(ss, QUEUE) == -1) {
        perror("listen");
        exit(1);
    }
    /*connect*/
    struct sockaddr_in client_addr;
    socklen_t length = sizeof(client_addr);
    ///成功返回非负描述字，出错返回-1
    int conn = accept(ss, (struct sockaddr*)&client_addr, &length);   //目测需要客户端部分的addr
    if( conn < 0 ) {
        perror("connect");
        exit(1);
    }
    
    while(1){
        fd = open("/dev/mem", (O_RDWR | O_SYNC));
        signal1  = (unsigned long*) mmap( NULL, signal1_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, (ALT_LWFPGASLVS_OFST + signal1_BASE) );
        signal2  = (unsigned long*) mmap( NULL, signal2_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, (ALT_LWFPGASLVS_OFST + signal2_BASE) );
        signal3  = (unsigned long*) mmap( NULL, signal3_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, (ALT_LWFPGASLVS_OFST + signal3_BASE) );
        signal4  = (unsigned long*) mmap( NULL, signal4_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, (ALT_LWFPGASLVS_OFST + signal4_BASE) );
        rdaddr  = (unsigned long*) mmap( NULL, rdaddr_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, (ALT_LWFPGASLVS_OFST + rdaddr_BASE) );
        rden  = (unsigned long*) mmap( NULL, rden_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, (ALT_LWFPGASLVS_OFST + rden_BASE) );
        rready  = (unsigned long*) mmap( NULL, rready_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, (ALT_LWFPGASLVS_OFST + rready_BASE) );
        q  = (unsigned long*) mmap( NULL, q_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, (ALT_LWFPGASLVS_OFST + q_BASE) );
        int addrvalue ;
        while(*rden == signum){
                  *rready^=0x00;

                  addrvalue=*rdaddr;

                       sig[0][addrvalue]=*signal1;
                       sig[1][addrvalue]=*signal2;
                       sig[2][addrvalue]=*signal3;
                       sig[3][addrvalue]=*signal4;

                       if(addrvalue==999){*rready^=0x01;}

               }

        munmap(signal1,signal1_SPAN);
        munmap(signal2,signal2_SPAN);
        munmap(signal3,signal3_SPAN);
        munmap(signal4,signal4_SPAN);
        munmap(rdaddr,rdaddr_SPAN);
        munmap(rden,rden_SPAN);
        munmap(rready,rready_SPAN);
        munmap(q,q_SPAN);
        close(fd);

        
        //数组赋值
        //recv(conn,(char *)&sig,sizeof(sig),0);
        int flat[4000];
        for(int i=0;i<4;i++){
            for(int j=0;j<1000;j++){
                flat[1000*i+j] = sig[i][j];
                }
            }
        send(conn,(char *)&flat,sizeof(flat),0);
    }

    //close(conn);
    //close(ss);
    return 0;
}