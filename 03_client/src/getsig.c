#include "getsig.h"
#include <stdio.h>
#include "unistd.h"
#include "fcntl.h"
#include "mman.h"

int getsig(int sig[4][1000] , int signum)
{
	int i,j,m,s[4000];
	while(1){
		for(i = 0; i < 4000; i++){
			scanf("%d",&s[i]);
		}
		for(j = 0; j < 4; j++){
			for(m = 0; m < 1000; m++){
				sig[j][m] = s[1000*j+m];
			}
		}
	}
}

