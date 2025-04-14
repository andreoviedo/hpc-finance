#include <stdio.h>
__global__ void add(float* a, float* b, float* c, int N)
{
   int stride = blockDim.x * gridDim.x;
   int threadId = threadIdx.x + blockIdx.x * blockDim.x;
   for (int idx=threadId; idx<N; idx+= stride)
       c[idx] = a[idx] + b[idx];
}

int main()
{
   int N = 1024;
   int numBytes = N * sizeof(float);
   float* h_a = (float *)malloc(numBytes);
   float* h_b = (float *)malloc(numBytes);
   float* h_c = (float *)malloc(numBytes);

   for (int i=0; i<N; ++i)
   {
      h_a[i] = i;
      h_b[i] = i;
      h_c[i] = 0;
   }

   float *d_a, *d_b, *d_c;
   cudaMalloc((float**)&d_a, numBytes); 
   cudaMalloc((float**)&d_b, numBytes);
   cudaMalloc((float**)&d_c, numBytes);

   cudaMemcpy(d_a, h_a, numBytes, cudaMemcpyHostToDevice);
   cudaMemcpy(d_b, h_b, numBytes, cudaMemcpyHostToDevice);

   add<<<2, 256>>>(d_a, d_b, d_c, N); // Here we create 2 blocks of 256 each, so 512 threads in total which is half of N
   cudaDeviceSynchronize();

   cudaMemcpy(h_c, d_c, numBytes, cudaMemcpyDeviceToHost);

   for (int i=0; i<N; ++i)
   {
     printf("%d: %f\n", i, h_c[i]);
   }

   cudaFree(d_a);
   cudaFree(d_b);
   cudaFree(d_c);

   free(h_a);
   free(h_b);
   free(h_c);

   return 0;
}
