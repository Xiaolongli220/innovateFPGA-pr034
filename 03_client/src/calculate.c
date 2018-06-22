#include "calculate.h"
#include <math.h>
#include <stdlib.h>
int calculate(int source[4][180][180],int signalmatrix[4][1000],int thetaphi[180][180],int A[2]){
int theta = 0 ;          //output
int phi = 0 ;            //output
A[0] = 0 ;
A[1] = 1 ;
int maxtheta = A[0];
int maxphi = A[1];
int max = 0 ;
int t1 = 0 ;
int p1 = 0;
int iter = 0;
int temp=0;
int temphigh = 0 ;
int templow = 0 ;
for(theta = 0 ; theta < 180 ; theta++){
	for(phi = 0 ; phi <180 ; phi++){
		for(iter = 0 ; iter < 40;iter++){
			temp = signalmatrix[0][(700+iter+source[0][theta][phi])]+
			signalmatrix[1][(700+iter+source[1][theta][phi])]+
			signalmatrix[2][(700+iter+source[2][theta][phi])]+
			signalmatrix[3][(700+iter+source[3][theta][phi])];
			if(temp < templow)
			{
				templow = temp ;
			}
			if(temp > temphigh)
			{
				temphigh = temp;
			}
		}
		thetaphi[theta][phi] = temphigh - templow;
//if(thetaphi[theta][phi] != 0)
//   printf("%d,", thetaphi[theta][phi]);
if(thetaphi[theta][phi] > max){
	max = thetaphi[theta][phi];
	maxtheta = theta ;
	maxphi = phi ;


	}
}
//printf("\n");
}
max = 0;
for(theta = 0 ; theta < 180 ; theta++){
	for(phi = 0 ; phi <180 ; phi++){
		for(iter = 0 ; iter < 40;iter++){
			temp = signalmatrix[0][(800+iter+source[0][theta][phi])]+
			signalmatrix[1][(800+iter+source[1][theta][phi])]+
			signalmatrix[2][(800+iter+source[2][theta][phi])]+
			signalmatrix[3][(800+iter+source[3][theta][phi])];
			if(temp < templow)
			{
				templow = temp ;
			}
			if(temp > temphigh)
			{
				temphigh = temp;
			}
		}
		thetaphi[theta][phi] = temphigh - templow;
//if(thetaphi[theta][phi] != 0)
//   printf("%d,", thetaphi[theta][phi]);
if(thetaphi[theta][phi] > max){
	max = thetaphi[theta][phi];
	t1 = theta ;
	p1 = phi ;


	}
}
//printf("\n");
}
if(abs(t1-maxtheta)<10 &&abs(p1-maxphi)<10){
	printf("theta:%d, phi:%d\n", maxtheta,maxphi);
A[0] = maxtheta ;
A[1] = maxphi ;
return 1 ;}
else{
	return 0;
}


}
