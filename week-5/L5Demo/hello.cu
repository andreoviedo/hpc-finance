#include <stdio.h>


__global__ void greeting()
{
   printf("Hello from GPU\n");
}

int main()
{
   greeting<<<1, 10>>>();

   cudaDeviceSynchronize();
}
