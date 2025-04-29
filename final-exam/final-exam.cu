// We will be using CUDA, so a .cu file is necessary

#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>
#include <random>
//#include <omp.h>
#include <iomanip>
#include <chrono>

// Might need to include other libraries

// CUDA
#include <cuda_runtime.h>

// Check if the time to populate is also part of the timer

#define N_PATHS 1000
#define PROB_UP 0.5
#define PROB_DOWN 0.5
#define N_OPTIONS 500

using namespace std::chrono; // Add namespace

// There is no "random" data being generated. Monte Carlo generates the randomess here

// We can directly jump into the implementation

struct MarketParams{
    float T;
    float r;
    float v;
};


const std::vector<MarketParams> marketData = {
    {0.5f, 0.03f, 0.30f},
    {0.75f, 0.04f, 0.29f},
    {1.0f, 0.05f, 0.28f},
    {1.25f, 0.06f, 0.27f},
    {1.5f, 0.07f, 0.26f}
};


// Check for CUDA here

// Host function to manage the CUDA kernel launch for generateLastStep

__global__ void generateLastStep_on_device(float* d_finalAssetPrices, float S0, float u, float d, int N) {
    int j = blockIdx.x * blockDim.x + threadIdx.x;

    // Check bounds: ensure we don't write past the end of the array
    // The array size is N + 1
    if (j <= N) {
        // Use powf for float exponentiation on the device
        d_finalAssetPrices[j] = S0 * powf(u, (float)j) * powf(d, (float)(N - j));
    }
}

float* generateLastStep_on_cpu(float S0, float T, int N, float sigma, float r) {
    // Calculate parameters on the host
    float dt = T / static_cast<float>(N);
    float sqrt_dt = std::sqrt(dt);
    float drift = r - 0.5f * sigma * sigma;
    float u = std::exp(drift * dt + sigma * sqrt_dt);
    float d = std::exp(drift * dt - sigma * sqrt_dt);

    // Allocate memory on the GPU
    int arraySize = N + 1;
    size_t memSize = arraySize * sizeof(float);
    float* d_finalAssetPrices;
    cudaMalloc(&d_finalAssetPrices, memSize);

    // Configure kernel launch parameters
    int threadsPerBlock = 256; // Common choice, can be tuned
    // Ensure enough blocks to cover all N+1 elements
    int blocksPerGrid = (arraySize + threadsPerBlock - 1) / threadsPerBlock;

    // Launch the kernel
    generateLastStep_on_device<<<blocksPerGrid, threadsPerBlock>>>(d_finalAssetPrices, S0, u, d, N);


    // Return the device pointer
    return d_finalAssetPrices;
}

__global__ void calculateTerminalPayoff_on_device(float* d_optionValues, const float* d_finalAssetPrices, float K, int N) {
    int j = blockIdx.x * blockDim.x + threadIdx.x;

    // Check bounds (array size is N+1)
    if (j <= N) {
        // Calculate Call option payoff: max(S_T - K, 0)
        d_optionValues[j] = fmaxf(d_finalAssetPrices[j] - K, 0.0f);
    }
}

// The backward induction is done here 

// Check for CUDA here

// Updated priceEuropeanOption (partially converted)
float priceEuropeanOption(
    float S0, float K, float T, int N, float sigma, float r)
{
    float dt = T / static_cast<float>(N);
    float p = PROB_UP;
    float q = PROB_DOWN;
    float discountFactor = std::exp(-r * dt);

    // Call the CUDA version to get prices on the GPU
    float* d_finalAssetPrices = generateLastStep_on_cpu(S0, T, N, sigma, r);

    // --- Allocate memory for option values on GPU ---
    int arraySize = N + 1;
    size_t memSize = arraySize * sizeof(float);
    float* d_optionValues;
    cudaMalloc(&d_optionValues, memSize);

    // --- Configure and launch terminal payoff kernel ---
    int threadsPerBlock = 256;
    int blocksPerGrid = (arraySize + threadsPerBlock - 1) / threadsPerBlock;
    calculateTerminalPayoff_on_device<<<blocksPerGrid, threadsPerBlock>>>(d_optionValues, d_finalAssetPrices, K, N);
    cudaGetLastError(); // Check kernel launch

    // --- Free d_finalAssetPrices - no longer needed ---
    cudaFree(d_finalAssetPrices);


    // --- !!! TEMPORARY: Copy d_optionValues back to CPU for the CPU backward loop !!! ---
    // --- !!! We will replace this in the next step.                            !!! ---
    std::vector<float> optionValues(N + 1); // Host vector
    cudaMemcpy(optionValues.data(), d_optionValues, memSize, cudaMemcpyDeviceToHost);


    // --- !!! The backward induction loop is STILL on the CPU !!! ---
    // --- !!! This loop WILL BE converted to CUDA kernels.      !!! ---
    for (int i = N - 1; i >= 0; --i) {
        // This inner loop needs i+1 calculations
        for (int j = 0; j <= i; ++j) {
            // Reading and writing to the temporary host vector optionValues
            optionValues[j] = discountFactor * (p * optionValues[j + 1] + q * optionValues[j]);
        }
    }

    // --- !!! Free d_optionValues (allocated on GPU) !!! ---
    // Important to free even though we used a temporary host copy for the loop
    cudaFree(d_optionValues);


    // Return the result calculated by the temporary host loop
    return optionValues[0];
}

// Function to calculate the sum of option prices

float sumOfOptionPrices(float S0){
    float currentSum = 0.0f;

    for(const auto& marketParams : marketData){
        float T = marketParams.T;
        float r = marketParams.r;
        float v = marketParams.v;
        for(int i = 0; i < N_OPTIONS; i++){
            float K = 50.0f + 1.0f * i;
            float price = priceEuropeanOption(S0, K, T, N_PATHS, v, r);
            currentSum += price;
        }
    }
    return currentSum;
}   

int step_a(){
    // Test with S0 = 100.0f

    float S0 = 100.0f;

    float currentSum = sumOfOptionPrices(S0);

    return currentSum;
}

int main(){
    std::cout << "Total sum of option prices: " << step_a() << std::endl;
    return 0;
}

// Compilation with:

// nvcc -o final-exam final-exam.cu
