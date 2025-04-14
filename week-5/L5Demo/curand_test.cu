/* * This program uses the host CURAND API to generate 100 
   pseudorandom floats. */ 

//taken from the following and modified slightly
//http://docs.nvidia.com/cuda/curand/host-api-overview.html#host-api-example 

#include <stdio.h> 
#include <stdlib.h> 
#include <cuda.h> 
#include <curand.h> 

int main(int argc, char *argv[]) 
{ 
   size_t N = 100; 
   curandGenerator_t gen; 
   float *devData, *hostData; 

   int numBytes = N*sizeof(float);

   /* Allocate n floats on host */ 
   hostData = (float *)malloc(numBytes); 

   /* Allocate n floats on device */ 
   cudaMalloc((float**)&devData, numBytes); 

   /* Create pseudo-random number generator */ 
   curandCreateGenerator(&gen, CURAND_RNG_PSEUDO_MTGP32);
  
   /* Set seed */ 
   curandSetPseudoRandomGeneratorSeed(gen, 19ULL); 
  
   /* Generate n floats on device */ 
   curandGenerateUniform(gen, devData, N); 
  
   /* Copy device memory to host */ 
   cudaMemcpy(hostData, devData, numBytes, 
         cudaMemcpyDeviceToHost); 
   
   /* Show result */ 
   for(int i = 0; i < 10; i++) 
   { 
        printf("%1.4f\n", hostData[i]); 
   } 

   /* Cleanup */ 
   curandDestroyGenerator(gen); 
  
   cudaFree(devData); 
   free(hostData); 

} 

