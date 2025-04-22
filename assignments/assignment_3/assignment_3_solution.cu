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

#define N_SIMULATIONS 1000000

using namespace std::chrono; // Add namespace

// Pre-thoughts:
// - We will need to use a lot of precomputed values
// - You know what would be ideal? If from all the greeks we can compute the option price
// - Check all the greeks for "common" arguments between them
//     - Ended up making a function to compute all the values at once to take advantage of this!

// Same helper function for random data generation

float random_data(float low, float hi)
{
    float r = (float)rand()/(float)RAND_MAX;
    return low + r*(hi-low);
}

// We need to add the CDF calculation

// Steps to optimize (most seen in class)
// CDF function from class Abramowitz and Stegun?


// OK Now CUDA version of the functions

// Creating both host and device versions of the functions because i will need them for the tests and the simulations

__host__ __device__ float cdf_normal(float x) // Straight from class
{
    const float b1 = 0.319381530;
    const float b2 = -0.356563782;
    const float b3 = 1.781477937;
    const float b4 = -1.821255978;
    const float b5 = 1.330274429;
    const float p = 0.2316419;
    const float c = 0.39894228;

    if (x >= 0.0)
    {
        float t = 1.0 / (1.0 + p * x);
        return (1.0 - c * exp(-x * x / 2.0) * t * (t *(t * (t * (t * b5 + b4) + b3) + b2) + b1));
    }
    else
    {
        float t = 1.0 / (1.0 - p * x);
        return (c * exp(-x * x / 2.0) * t * (t *(t * (t * (t * b5 + b4) + b3) + b2) + b1));
    }
}

// Normal distribution probability density function (needed for gamma)
__host__ __device__ float pdf_normal(float x) {
    return 0.39894228f * exp(-0.5f * x * x);
}

// We need to define the Option type as in Assignment 2

enum class OptionType {
    Call,
    Put
};

// We will use a function to price the option depending on the type

__host__ __device__ float price_option(float S0, float K, float T, float v, float r, OptionType optionType)
{
    float d1 = (log(S0 / K) + (r + 0.5f * v * v) * T) / (v * sqrt(T));
    float d2 = d1 - v * sqrt(T);

    float nd1 = cdf_normal(d1);
    float nd2 = cdf_normal(d2);

    if (optionType == OptionType::Call) {
        return S0 * nd1 - K * exp(-r * T) * nd2;
    } else {
        return K * exp(-r * T) * (1.0f - nd2) - S0 * (1.0f - nd1);
    }
}

// We need to define the greeks

// Required greeks: delta, gamma, vega, rho, and theta.

// One thing I didn't fully thought of was that we will need to compute the inverse of the CDF...

__host__ __device__ void compute_all_option_values(
    float S0, float K, float T, float v, float r,
    float& call_price, float& put_price, 
    float& delta_call, float& delta_put,
    float& gamma_val, float& vega_val,
    float& rho_call, float& rho_put,
    float& theta_call, float& theta_put) {
    
    // Calculate common values once
    float sqrt_T = sqrt(T);
    float d1 = (log(S0 / K) + (r + 0.5f * v * v) * T) / (v * sqrt_T);
    float d2 = d1 - v * sqrt_T;
    float nd1 = cdf_normal(d1);
    float nd2 = cdf_normal(d2);
    float pd1 = pdf_normal(d1);
    float exp_rt = exp(-r * T);
    
    // Option prices
    call_price = S0 * nd1 - K * exp_rt * nd2;
    put_price = K * exp_rt * (1.0f - nd2) - S0 * (1.0f - nd1);
    
    // Delta
    // Has two different values depending if the option is aa call or a put
    delta_call = nd1;
    delta_put = nd1 - 1.0f;
    
    // Gamma (same for both call and put)
    gamma_val = pd1 / (S0 * v * sqrt_T);
    
    // Vega (same for both call and put)
    vega_val = S0 * sqrt_T * pd1 * 0.01f;
    
    // Rho
    // Same as delta, has two different values depending if the option is a call or a put
    rho_call = K * T * exp_rt * nd2 * 0.01f;
    rho_put = -K * T * exp_rt * (1.0f - nd2) * 0.01f;
    
    // Theta
    float term1 = -(S0 * v * pd1) / (2.0f * sqrt_T);
    theta_call = (term1 - r * K * exp_rt * nd2) / 365.0f; // In days 
    theta_put = (term1 + r * K * exp_rt * (1.0f - nd2)) / 365.0f; // In days
}

// This was a tricky one:

// At first I was trying to compute the values for each option in the kernel, but then I realized that I could just compute all the values at once
// This way I can use the same values for all the options and avoid having to compute them multiple times

// I guess this should've been an obvious choice to make but it was hard at first to look at it lol

// The only issue is that I am not sure why but I didn't find any huge performance gains from this... 

// I was tried to look for other optimizations but I thiiiink they are quite outside of the scope of the assignment/coursee

__global__ void option_pricing_kernel(

    // This takes multiple pointers but also has multiple outputs
    // Because I want to compute all at the same time :)

    float* S0, float* K, float* T, float* sigma, float* r, 
    float* call_prices, float* put_prices, 
    float* delta_calls, float* delta_puts,
    float* gammas, float* vegas,
    float* rho_calls, float* rho_puts,
    float* theta_calls, float* theta_puts,
    int num_options) {
    
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < num_options) {
        compute_all_option_values(
            S0[idx], K[idx], T[idx], sigma[idx], r[idx],
            call_prices[idx], put_prices[idx],
            delta_calls[idx], delta_puts[idx],
            gammas[idx], vegas[idx],
            rho_calls[idx], rho_puts[idx],
            theta_calls[idx], theta_puts[idx]
        );
    }
}

// Part 1: tests

// a)   S = 90;  r = 0.03; v = 0.3, T= 1, K=90
// b)   S = 95; r = 0.03,  v= 0.3;  T= 1, K=90
// c)   S = 100;  r = 0.03; v = 0.3;  T= 2, K=100
// d)   S = 105; r = 0.03,  v= 0.3;  T= 2, K=100
// e)   S = 110; r = 0.03,  v= 0.3;  T= 2, K=100

int tests() {
    float r = 0.03f;
    float sigma = 0.3f;

    // Test case a
    

    // For each test I just change whatever changes, not all parameters

    float S0_a = 90.0f, K_a = 90.0f, T_a = 1.0f;
    
    // All objects

    float call_price_a, put_price_a, delta_call_a, delta_put_a, gamma_a, vega_a, rho_call_a, rho_put_a, theta_call_a, theta_put_a;
    
    // Compute all values at the same time

    compute_all_option_values(S0_a, K_a, T_a, sigma, r, 
                              call_price_a, put_price_a, delta_call_a, delta_put_a, gamma_a, vega_a, 
                              rho_call_a, rho_put_a, theta_call_a, theta_put_a);
    
    std::cout << "a) S = " << S0_a << ", K = " << K_a << ", T = " << T_a << ":" << std::endl;
    std::cout << "   Call Price = " << call_price_a << ", Put Price = " << put_price_a << std::endl;
    std::cout << "   Delta Call = " << delta_call_a << ", Delta Put = " << delta_put_a << std::endl;
    std::cout << "   Gamma = " << gamma_a << std::endl;
    std::cout << "   Vega = " << vega_a << std::endl;
    std::cout << "   Theta Call = " << theta_call_a << ", Theta Put = " << theta_put_a << std::endl;
    std::cout << "   Rho Call = " << rho_call_a << ", Rho Put = " << rho_put_a << std::endl;
    std::cout << std::endl;
    
    // Test case b
    float S0_b = 95.0f, K_b = 90.0f, T_b = 1.0f;
    
    float call_price_b, put_price_b, delta_call_b, delta_put_b, gamma_b, vega_b, rho_call_b, rho_put_b, theta_call_b, theta_put_b;
    
    compute_all_option_values(S0_b, K_b, T_b, sigma, r, 
                              call_price_b, put_price_b, delta_call_b, delta_put_b, gamma_b, vega_b, 
                              rho_call_b, rho_put_b, theta_call_b, theta_put_b);

    std::cout << "b) S = " << S0_b << ", K = " << K_b << ", T = " << T_b << ":" << std::endl;
    std::cout << "   Call Price = " << call_price_b << ", Put Price = " << put_price_b << std::endl;
    std::cout << "   Delta Call = " << delta_call_b << ", Delta Put = " << delta_put_b << std::endl;
    std::cout << "   Gamma = " << gamma_b << std::endl;
    std::cout << "   Vega = " << vega_b << std::endl;
    std::cout << "   Theta Call = " << theta_call_b << ", Theta Put = " << theta_put_b << std::endl;
    std::cout << "   Rho Call = " << rho_call_b << ", Rho Put = " << rho_put_b << std::endl;
    std::cout << std::endl;

    // Test case c
    float S0_c = 100.0f, K_c = 100.0f, T_c = 2.0f;
    
    float call_price_c, put_price_c, delta_call_c, delta_put_c, gamma_c, vega_c, rho_call_c, rho_put_c, theta_call_c, theta_put_c;
    
    compute_all_option_values(S0_c, K_c, T_c, sigma, r, 
                              call_price_c, put_price_c, delta_call_c, delta_put_c, gamma_c, vega_c, 
                              rho_call_c, rho_put_c, theta_call_c, theta_put_c);

    std::cout << "c) S = " << S0_c << ", K = " << K_c << ", T = " << T_c << ":" << std::endl;
    std::cout << "   Call Price = " << call_price_c << ", Put Price = " << put_price_c << std::endl;
    std::cout << "   Delta Call = " << delta_call_c << ", Delta Put = " << delta_put_c << std::endl;
    std::cout << "   Gamma = " << gamma_c << std::endl;
    std::cout << "   Vega = " << vega_c << std::endl;
    std::cout << "   Theta Call = " << theta_call_c << ", Theta Put = " << theta_put_c << std::endl;
    std::cout << "   Rho Call = " << rho_call_c << ", Rho Put = " << rho_put_c << std::endl;
    std::cout << std::endl;

    // Test case d
    float S0_d = 105.0f, K_d = 100.0f, T_d = 2.0f;
    
    float call_price_d, put_price_d, delta_call_d, delta_put_d, gamma_d, vega_d, rho_call_d, rho_put_d, theta_call_d, theta_put_d;
    
    compute_all_option_values(S0_d, K_d, T_d, sigma, r, 
                              call_price_d, put_price_d, delta_call_d, delta_put_d, gamma_d, vega_d, 
                              rho_call_d, rho_put_d, theta_call_d, theta_put_d);

    std::cout << "d) S = " << S0_d << ", K = " << K_d << ", T = " << T_d << ":" << std::endl;
    std::cout << "   Call Price = " << call_price_d << ", Put Price = " << put_price_d << std::endl;
    std::cout << "   Delta Call = " << delta_call_d << ", Delta Put = " << delta_put_d << std::endl;
    std::cout << "   Gamma = " << gamma_d << std::endl;
    std::cout << "   Vega = " << vega_d << std::endl;
    std::cout << "   Theta Call = " << theta_call_d << ", Theta Put = " << theta_put_d << std::endl;
    std::cout << "   Rho Call = " << rho_call_d << ", Rho Put = " << rho_put_d << std::endl;
    std::cout << std::endl;

    // Test case e
    float S0_e = 110.0f, K_e = 100.0f, T_e = 2.0f;
    
    float call_price_e, put_price_e, delta_call_e, delta_put_e, gamma_e, vega_e, rho_call_e, rho_put_e, theta_call_e, theta_put_e;
    
    compute_all_option_values(S0_e, K_e, T_e, sigma, r, 
                              call_price_e, put_price_e, delta_call_e, delta_put_e, gamma_e, vega_e, 
                              rho_call_e, rho_put_e, theta_call_e, theta_put_e);

    std::cout << "e) S = " << S0_e << ", K = " << K_e << ", T = " << T_e << ":" << std::endl;
    std::cout << "   Call Price = " << call_price_e << ", Put Price = " << put_price_e << std::endl;
    std::cout << "   Delta Call = " << delta_call_e << ", Delta Put = " << delta_put_e << std::endl;
    std::cout << "   Gamma = " << gamma_e << std::endl;
    std::cout << "   Vega = " << vega_e << std::endl;
    std::cout << "   Theta Call = " << theta_call_e << ", Theta Put = " << theta_put_e << std::endl;
    std::cout << "   Rho Call = " << rho_call_e << ", Rho Put = " << rho_put_e << std::endl;
    
    return 0;
}

int simulation() {
    int num_simulations = N_SIMULATIONS;
    
    // Same object as in the previous assignment

    std::vector<float> S0_inputs(num_simulations);
    std::vector<float> K_inputs(num_simulations);
    std::vector<float> T_inputs(num_simulations);
    std::vector<float> sigma_inputs(num_simulations);
    std::vector<float> r_inputs(num_simulations);
    std::vector<float> results(num_simulations);

    std::cout << "Generating random data..." << std::endl;

    for (int i = 0; i < num_simulations; ++i) {
        S0_inputs[i] = random_data(80.0f, 120.0f);
        K_inputs[i] = random_data(80.0f, 120.0f);
        T_inputs[i] = random_data(0.1f, 2.0f);
        sigma_inputs[i] = random_data(0.05f, 0.5f);
        r_inputs[i] = random_data(0.0f, 0.1f);
    }

    high_resolution_clock::time_point t1 = high_resolution_clock::now();


    // Difference compared to the previous assignment: we have to compute both call and put prices (and greeks for both in case they are needed)
    std::cout << "Computing prices and greeks..." << std::endl;
    
    // Allocate device memory for all objectsss

    float *d_S0, *d_K, *d_T, *d_sigma, *d_r;
    float *d_call_prices, *d_put_prices;
    float *d_delta_calls, *d_delta_puts, *d_gammas, *d_vegas;
    float *d_rho_calls, *d_rho_puts, *d_theta_calls, *d_theta_puts;

    // Allocate and copy input data for ALL objects: inputs (copied) and outputs (computed then copied back)

    cudaMalloc(&d_S0, num_simulations * sizeof(float));
    cudaMalloc(&d_K, num_simulations * sizeof(float));
    cudaMalloc(&d_T, num_simulations * sizeof(float));
    cudaMalloc(&d_sigma, num_simulations * sizeof(float));
    cudaMalloc(&d_r, num_simulations * sizeof(float));
    cudaMalloc(&d_call_prices, num_simulations * sizeof(float));
    cudaMalloc(&d_put_prices, num_simulations * sizeof(float));
    cudaMalloc(&d_delta_calls, num_simulations * sizeof(float));
    cudaMalloc(&d_delta_puts, num_simulations * sizeof(float));
    cudaMalloc(&d_gammas, num_simulations * sizeof(float));
    cudaMalloc(&d_vegas, num_simulations * sizeof(float));
    cudaMalloc(&d_rho_calls, num_simulations * sizeof(float));
    cudaMalloc(&d_rho_puts, num_simulations * sizeof(float));
    cudaMalloc(&d_theta_calls, num_simulations * sizeof(float));
    cudaMalloc(&d_theta_puts, num_simulations * sizeof(float));

    // Copy all inputs to the device

    cudaMemcpy(d_S0, S0_inputs.data(), num_simulations * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_K, K_inputs.data(), num_simulations * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_T, T_inputs.data(), num_simulations * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_sigma, sigma_inputs.data(), num_simulations * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_r, r_inputs.data(), num_simulations * sizeof(float), cudaMemcpyHostToDevice);

    // Launch kernel

    // I was trying to use different block size but I didn't see any performance gains idk why

    int blockSize = 256;
    int numBlocks = (num_simulations + blockSize - 1) / blockSize; // I googled for this formula

    option_pricing_kernel<<<numBlocks, blockSize>>>(
        d_S0, d_K, d_T, d_sigma, d_r,
        d_call_prices, d_put_prices,
        d_delta_calls, d_delta_puts,
        d_gammas, d_vegas,
        d_rho_calls, d_rho_puts,
        d_theta_calls, d_theta_puts,
        num_simulations);

    // Allocate objects for all outputs

    std::vector<float> call_prices(num_simulations);
    std::vector<float> put_prices(num_simulations);
    std::vector<float> delta_calls(num_simulations);
    std::vector<float> delta_puts(num_simulations);
    std::vector<float> gammas(num_simulations);
    std::vector<float> vegas(num_simulations);
    std::vector<float> rho_calls(num_simulations);
    std::vector<float> rho_puts(num_simulations);
    std::vector<float> theta_calls(num_simulations);
    std::vector<float> theta_puts(num_simulations);


    // Copy results back

    cudaMemcpy(call_prices.data(), d_call_prices, num_simulations * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(put_prices.data(), d_put_prices, num_simulations * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(delta_calls.data(), d_delta_calls, num_simulations * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(delta_puts.data(), d_delta_puts, num_simulations * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(gammas.data(), d_gammas, num_simulations * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(vegas.data(), d_vegas, num_simulations * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(rho_calls.data(), d_rho_calls, num_simulations * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(rho_puts.data(), d_rho_puts, num_simulations * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(theta_calls.data(), d_theta_calls, num_simulations * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(theta_puts.data(), d_theta_puts, num_simulations * sizeof(float), cudaMemcpyDeviceToHost);

    // Print the first call price to verify results

    std::cout << "First calculated call price: " << call_prices[0] << std::endl;

    // Free device memory

    cudaFree(d_S0);
    cudaFree(d_K);
    cudaFree(d_T);
    cudaFree(d_sigma);
    cudaFree(d_r);
    cudaFree(d_call_prices);
    cudaFree(d_put_prices);
    cudaFree(d_delta_calls);
    cudaFree(d_delta_puts);
    cudaFree(d_gammas);
    cudaFree(d_vegas);
    cudaFree(d_rho_calls);
    cudaFree(d_rho_puts);
    cudaFree(d_theta_calls);
    cudaFree(d_theta_puts);

    high_resolution_clock::time_point t2 = high_resolution_clock::now();
    auto duration = duration_cast<milliseconds>(t2 - t1);
    std::cout << "Time taken by function: " << duration.count() << " milliseconds" << std::endl;
    
    return 0;
}

int main() {
    tests();
    simulation();
    return 0;
}