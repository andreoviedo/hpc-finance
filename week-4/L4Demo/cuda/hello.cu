#include <stdio.h>
__global__ void greeting()
{
	printf("Hello, World\n");
}
int main()
{
	greeting<<<1, 10>>>();
	cudaDeviceSynchronize();
}
