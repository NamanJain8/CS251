
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>


#define NUM 10000
#define SEED 18
#define CUDA_ERROR_EXIT(str) do{\
				cudaError err = cudaGetLastError();\
				if(err!=cudaSuccess){\
					printf("Cuda Error: %s for %s \n",cudaGetErrorString(err),str);\
					exit(-1);\
					}\
				}while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))


__global__ void calculate(int *d_arr,unsigned long num,int merge_size){
	int i=blockIdx.x * blockDim.x + threadIdx.x;
	if(i%merge_size!=0 || i>num)
		return;
	if(i+merge_size/2<num)
		d_arr[i]=d_arr[i]^d_arr[i+merge_size/2];
	return;
}



int main(int argc, char **argv)
{
	struct timeval start, end, t_start, t_end;
	if(argc!=3)
	{
		printf("Insufficient number of arguments");
		exit(-1);
	}
	
	unsigned long num=NUM;
	num = atoi(argv[1]);
	unsigned long seed=SEED;
 	seed = atoi(argv[2]);
	
	srand(seed);

	int *h_arr;
	int *d_arr;
	h_arr=(int *)malloc(num*sizeof(num));
	for(int i=0;i<num;i++)
		h_arr[i]=rand();

	/*	
	h_arr[0]=10;
	h_arr[1]=9;
	h_arr[2]=19;
	h_arr[3]=5;
	h_arr[4]=4;*/
	
	gettimeofday(&t_start,NULL);
	cudaMalloc(&d_arr,num*sizeof(int));
	CUDA_ERROR_EXIT("cudamalloc");

	cudaMemcpy(d_arr,h_arr,num*sizeof(int),cudaMemcpyHostToDevice);
	CUDA_ERROR_EXIT("memcpy");
	
	gettimeofday(&start,NULL);
	int merge_size=1;
	while(merge_size<num){
		merge_size*=2;
		calculate<<< (1023+num)/1024,1024  >>> (d_arr,num,merge_size);
	}
	gettimeofday(&end,NULL);
	
	cudaMemcpy(h_arr,d_arr,num*sizeof(int),cudaMemcpyDeviceToHost);
	CUDA_ERROR_EXIT("memcpy");
	gettimeofday(&t_end,NULL);	

//	printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
	printf("%d\n",h_arr[0]);

	cudaFree(d_arr);
	free(h_arr);
	return 0;	
}	
