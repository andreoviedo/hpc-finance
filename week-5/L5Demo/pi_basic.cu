#include <stdio.h> 
#include <stdlib.h> 
#include <cuda.h> 
#include <curand.h> 
#include <time.h> 
#include <cuda_profiler_api.h>
#include <chrono>

__global__ void pi_kernel(float* x, float* y, int* results) 
{ 
   float x_coord,y_coord, distance; 
   
   int tid = blockDim.x * blockIdx.x + threadIdx.x; 

   x_coord = x[tid]; 
   y_coord = y[tid]; 

   distance = x_coord*x_coord + y_coord*y_coord; 

   if (distance <= 1) 
     results[tid] = 1; //inside
   else
     results[tid] = 0; //outside 
} 


int main(int argc,char* argv[]) 
{ 
   size_t N = 1024*256; 
   curandGenerator_t gen; 
   float *d_x; 
   float *d_y; 

   std::chrono::high_resolution_clock::time_point t1 = 
	   std::chrono::high_resolution_clock::now();

   int numBytes = N*sizeof(float);

   /* Allocate n floats on device */ 
   cudaMalloc((float**)&d_x, numBytes); 
   cudaMalloc((float**)&d_y, numBytes); 

   /* Create pseudo-random number generator */ 
   curandCreateGenerator(&gen, CURAND_RNG_PSEUDO_MTGP32); 
   
   /* Set seed */ 
   curandSetPseudoRandomGeneratorSeed(gen, 1234ULL); 
   /* Generate n floats on device */ 
   curandGenerateUniform(gen, d_x, N); 
   curandGenerateUniform(gen, d_y, N); 

   int threads_per_block = 1024; 
   //Number of thread blocks launched 
   int numblocks = 256; 
   
   int *h_points = (int*)malloc(N*sizeof(int)); 
   int *d_points; 

   //Allocate the array to hold a value (1,0) whether the point in is the circle (1) or not (0) 
   cudaMalloc((void**)&d_points, N*sizeof(int)); 
   
   //Launch the kernel 
   pi_kernel<<<numblocks, threads_per_block>>>(d_x, d_y,d_points); 

   cudaDeviceSynchronize(); 
  
   //Copy the resulting array back 
   cudaMemcpy(h_points, d_points, N*sizeof(int), cudaMemcpyDeviceToHost); 


   unsigned int inside_circle = 0;
   for(int i = 0; i<N; i++) 
       inside_circle += h_points[i]; 

        
    float pi = ((float)inside_circle/N)*4.0; 
   
    std::chrono::high_resolution_clock::time_point t2 = 
	   std::chrono::high_resolution_clock::now();
    
    printf("pi: %f\n", pi); 
    printf("elapsed time: %d (ms)\n", std::chrono::duration_cast<std::chrono::milliseconds>(t2-t1).count());
    cudaProfilerStop();
    cudaDeviceReset();

    cudaFree(d_x); 
    cudaFree(d_y); 
    cudaFree(d_points); 

    free(h_points);


    return 0; 
}
