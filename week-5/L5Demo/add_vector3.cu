#include <stdio.h>

__global__ void add(float* a, float* b, float* c)
{
   int idx = threadIdx.x + blockIdx.x * blockDim.x;
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
   cudaError_t errCode = cudaMalloc((float**)&d_a, numBytes); 
   if (errCode != cudaSuccess)
   {
      printf("cudaMalloc Failed\n");
      exit(EXIT_FAILURE);
   }

   errCode = cudaMalloc((float**)&d_b, numBytes);
   if (errCode != cudaSuccess) 
   {
           printf("cudaMalloc returned %d\n-> %s\n",
                        static_cast<int>(errCode), cudaGetErrorString(errCode));
           exit(EXIT_FAILURE);
   }
   

   errCode = cudaMalloc((float**)&d_c, numBytes);
   if (errCode != cudaSuccess) 
   {
           printf("cudaMalloc returned %d\n-> %s\n",
                        static_cast<int>(errCode), cudaGetErrorString(errCode));
           exit(EXIT_FAILURE);
   }
   

   cudaMemcpy(d_a, h_a, numBytes, cudaMemcpyHostToDevice);
   cudaMemcpy(d_b, h_b, numBytes, cudaMemcpyHostToDevice);

   add<<<1, N>>>(d_a, d_b, d_c);
   
   cudaDeviceSynchronize();
 
   errCode = cudaGetLastError();
   if (errCode != cudaSuccess) 
   {
           printf("kernet launch returned %d\n-> %s\n",
                        static_cast<int>(errCode), cudaGetErrorString(errCode));
           exit(EXIT_FAILURE);
   }

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
