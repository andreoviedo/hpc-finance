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

// Delta: first derivative of the option price with respect to the stock price
// - Delta depends on the option type

__host__ __device__ float delta(float S0, float K, float T, float v, float r, OptionType optionType) {
    float d1 = (log(S0 / K) + (r + 0.5f * v * v) * T) / (v * sqrt(T));
    
    if (optionType == OptionType::Call) {
        return cdf_normal(d1);
    } else {
        return cdf_normal(d1) - 1.0f;
    }
}

// Gamma: second derivative of the option price with respect to the stock price

// This doesn't depend on the option type!!! But has we have to compute the pdf

__host__ __device__ float gamma(float S0, float K, float T, float v, float r) {
    float d1 = (log(S0 / K) + (r + 0.5f * v * v) * T) / (v * sqrt(T));
    return pdf_normal(d1) / (S0 * v * sqrt(T));
}

// Vega: first derivative of the option price with respect to the volatility

__host__ __device__ float vega(float S0, float K, float T, float v, float r) {
    float d1 = (log(S0 / K) + (r + 0.5f * v * v) * T) / (v * sqrt(T));
    return S0 * sqrt(T) * pdf_normal(d1) * 0.01f; // Multiplied by 0.01 for 1% change
}

// Rho: first derivative of the option price with respect to the risk-free interest rate

__host__ __device__ float rho(float S0, float K, float T, float v, float r, OptionType optionType) {
    float d1 = (log(S0 / K) + (r + 0.5f * v * v) * T) / (v * sqrt(T));
    float d2 = d1 - v * sqrt(T);
    
    if (optionType == OptionType::Call) {
        return K * T * exp(-r * T) * cdf_normal(d2) * 0.01f; // Multiplied by 0.01 for 1% change
    } else {
        return -K * T * exp(-r * T) * (1.0f - cdf_normal(d2)) * 0.01f;
    }
}

// Theta: first derivative of the option price with respect to the time to maturity

// This depends on the option type

__host__ __device__ float theta(float S0, float K, float T, float v, float r, OptionType optionType) {
    float d1 = (log(S0 / K) + (r + 0.5f * v * v) * T) / (v * sqrt(T));
    float d2 = d1 - v * sqrt(T);
    
    float term1 = -(S0 * v * pdf_normal(d1)) / (2.0f * sqrt(T));
    
    if (optionType == OptionType::Call) {
        float term2 = -r * K * exp(-r * T) * cdf_normal(d2);
        return (term1 + term2) / 365.0f; // Divided by 365 for daily effect
    } else {
        float term2 = r * K * exp(-r * T) * (1.0f - cdf_normal(d2));
        return (term1 + term2) / 365.0f;
    }
}



// Part 1: tests


// a)   S = 90;  r = 0.03; v = 0.3, T= 1, K=90
// b)   S = 95; r = 0.03,  v= 0.3;  T= 1, K=90
// c)   S = 100;  r = 0.03; v = 0.3;  T= 2, K=100
// d)   S = 105; r = 0.03,  v= 0.3;  T= 2, K=100
// e)   S = 110; r = 0.03,  v= 0.3;  T= 2, K=100

int tests() {
    // Test case a
    float S0_a = 90.0f;
    float K_a = 90.0f;
    float r = 0.03f;
    float sigma = 0.3f;
    float T_a = 1.0f;
    
    float call_price_a = price_option(S0_a, K_a, T_a, sigma, r, OptionType::Call);
    float put_price_a = price_option(S0_a, K_a, T_a, sigma, r, OptionType::Put);
    float delta_call_a = delta(S0_a, K_a, T_a, sigma, r, OptionType::Call);
    float delta_put_a = delta(S0_a, K_a, T_a, sigma, r, OptionType::Put);
    float gamma_a = gamma(S0_a, K_a, T_a, sigma, r);
    float vega_a = vega(S0_a, K_a, T_a, sigma, r);
    float theta_call_a = theta(S0_a, K_a, T_a, sigma, r, OptionType::Call);
    float theta_put_a = theta(S0_a, K_a, T_a, sigma, r, OptionType::Put);
    float rho_call_a = rho(S0_a, K_a, T_a, sigma, r, OptionType::Call);
    float rho_put_a = rho(S0_a, K_a, T_a, sigma, r, OptionType::Put);
    
    std::cout << "a) S = " << S0_a << ", K = " << K_a << ", T = " << T_a << ":" << std::endl;
    std::cout << "   Call Price = " << call_price_a << ", Put Price = " << put_price_a << std::endl;
    std::cout << "   Delta Call = " << delta_call_a << ", Delta Put = " << delta_put_a << std::endl;
    std::cout << "   Gamma = " << gamma_a << std::endl;
    std::cout << "   Vega = " << vega_a << std::endl;
    std::cout << "   Theta Call = " << theta_call_a << ", Theta Put = " << theta_put_a << std::endl;
    std::cout << "   Rho Call = " << rho_call_a << ", Rho Put = " << rho_put_a << std::endl;
    std::cout << std::endl;
    
    // Test case b
    float S0_b = 95.0f;
    float K_b = 90.0f;
    float T_b = 1.0f;
    
    float call_price_b = price_option(S0_b, K_b, T_b, sigma, r, OptionType::Call);
    float put_price_b = price_option(S0_b, K_b, T_b, sigma, r, OptionType::Put);
    float delta_call_b = delta(S0_b, K_b, T_b, sigma, r, OptionType::Call);
    float delta_put_b = delta(S0_b, K_b, T_b, sigma, r, OptionType::Put);
    float gamma_b = gamma(S0_b, K_b, T_b, sigma, r);
    float vega_b = vega(S0_b, K_b, T_b, sigma, r);
    float theta_call_b = theta(S0_b, K_b, T_b, sigma, r, OptionType::Call);
    float theta_put_b = theta(S0_b, K_b, T_b, sigma, r, OptionType::Put);
    float rho_call_b = rho(S0_b, K_b, T_b, sigma, r, OptionType::Call);
    float rho_put_b = rho(S0_b, K_b, T_b, sigma, r, OptionType::Put);
    
    std::cout << "b) S = " << S0_b << ", K = " << K_b << ", T = " << T_b << ":" << std::endl;
    std::cout << "   Call Price = " << call_price_b << ", Put Price = " << put_price_b << std::endl;
    std::cout << "   Delta Call = " << delta_call_b << ", Delta Put = " << delta_put_b << std::endl;
    std::cout << "   Gamma = " << gamma_b << std::endl;
    std::cout << "   Vega = " << vega_b << std::endl;
    std::cout << "   Theta Call = " << theta_call_b << ", Theta Put = " << theta_put_b << std::endl;
    std::cout << "   Rho Call = " << rho_call_b << ", Rho Put = " << rho_put_b << std::endl;
    std::cout << std::endl;
    
    // Test case c
    float S0_c = 100.0f;
    float K_c = 100.0f;
    float T_c = 2.0f;
    
    float call_price_c = price_option(S0_c, K_c, T_c, sigma, r, OptionType::Call);
    float put_price_c = price_option(S0_c, K_c, T_c, sigma, r, OptionType::Put);
    float delta_call_c = delta(S0_c, K_c, T_c, sigma, r, OptionType::Call);
    float delta_put_c = delta(S0_c, K_c, T_c, sigma, r, OptionType::Put);
    float gamma_c = gamma(S0_c, K_c, T_c, sigma, r);
    float vega_c = vega(S0_c, K_c, T_c, sigma, r);
    float theta_call_c = theta(S0_c, K_c, T_c, sigma, r, OptionType::Call);
    float theta_put_c = theta(S0_c, K_c, T_c, sigma, r, OptionType::Put);
    float rho_call_c = rho(S0_c, K_c, T_c, sigma, r, OptionType::Call);
    float rho_put_c = rho(S0_c, K_c, T_c, sigma, r, OptionType::Put);
    
    std::cout << "c) S = " << S0_c << ", K = " << K_c << ", T = " << T_c << ":" << std::endl;
    std::cout << "   Call Price = " << call_price_c << ", Put Price = " << put_price_c << std::endl;
    std::cout << "   Delta Call = " << delta_call_c << ", Delta Put = " << delta_put_c << std::endl;
    std::cout << "   Gamma = " << gamma_c << std::endl;
    std::cout << "   Vega = " << vega_c << std::endl;
    std::cout << "   Theta Call = " << theta_call_c << ", Theta Put = " << theta_put_c << std::endl;
    std::cout << "   Rho Call = " << rho_call_c << ", Rho Put = " << rho_put_c << std::endl;
    std::cout << std::endl;
    
    // Test case d
    float S0_d = 105.0f;
    float K_d = 100.0f;
    float T_d = 2.0f;
    
    float call_price_d = price_option(S0_d, K_d, T_d, sigma, r, OptionType::Call);
    float put_price_d = price_option(S0_d, K_d, T_d, sigma, r, OptionType::Put);
    float delta_call_d = delta(S0_d, K_d, T_d, sigma, r, OptionType::Call);
    float delta_put_d = delta(S0_d, K_d, T_d, sigma, r, OptionType::Put);
    float gamma_d = gamma(S0_d, K_d, T_d, sigma, r);
    float vega_d = vega(S0_d, K_d, T_d, sigma, r);
    float theta_call_d = theta(S0_d, K_d, T_d, sigma, r, OptionType::Call);
    float theta_put_d = theta(S0_d, K_d, T_d, sigma, r, OptionType::Put);
    float rho_call_d = rho(S0_d, K_d, T_d, sigma, r, OptionType::Call);
    float rho_put_d = rho(S0_d, K_d, T_d, sigma, r, OptionType::Put);
    
    std::cout << "d) S = " << S0_d << ", K = " << K_d << ", T = " << T_d << ":" << std::endl;
    std::cout << "   Call Price = " << call_price_d << ", Put Price = " << put_price_d << std::endl;
    std::cout << "   Delta Call = " << delta_call_d << ", Delta Put = " << delta_put_d << std::endl;
    std::cout << "   Gamma = " << gamma_d << std::endl;
    std::cout << "   Vega = " << vega_d << std::endl;
    std::cout << "   Theta Call = " << theta_call_d << ", Theta Put = " << theta_put_d << std::endl;
    std::cout << "   Rho Call = " << rho_call_d << ", Rho Put = " << rho_put_d << std::endl;
    std::cout << std::endl;
    
    // Test case e
    float S0_e = 110.0f;
    float K_e = 100.0f;
    float T_e = 2.0f;
    
    float call_price_e = price_option(S0_e, K_e, T_e, sigma, r, OptionType::Call);
    float put_price_e = price_option(S0_e, K_e, T_e, sigma, r, OptionType::Put);
    float delta_call_e = delta(S0_e, K_e, T_e, sigma, r, OptionType::Call);
    float delta_put_e = delta(S0_e, K_e, T_e, sigma, r, OptionType::Put);
    float gamma_e = gamma(S0_e, K_e, T_e, sigma, r);
    float vega_e = vega(S0_e, K_e, T_e, sigma, r);
    float theta_call_e = theta(S0_e, K_e, T_e, sigma, r, OptionType::Call);
    float theta_put_e = theta(S0_e, K_e, T_e, sigma, r, OptionType::Put);
    float rho_call_e = rho(S0_e, K_e, T_e, sigma, r, OptionType::Call);
    float rho_put_e = rho(S0_e, K_e, T_e, sigma, r, OptionType::Put);
    
    std::cout << "e) S = " << S0_e << ", K = " << K_e << ", T = " << T_e << ":" << std::endl;
    std::cout << "   Call Price = " << call_price_e << ", Put Price = " << put_price_e << std::endl;
    std::cout << "   Delta Call = " << delta_call_e << ", Delta Put = " << delta_put_e << std::endl;
    std::cout << "   Gamma = " << gamma_e << std::endl;
    std::cout << "   Vega = " << vega_e << std::endl;
    std::cout << "   Theta Call = " << theta_call_e << ", Theta Put = " << theta_put_e << std::endl;
    std::cout << "   Rho Call = " << rho_call_e << ", Rho Put = " << rho_put_e << std::endl;
    
    return 0;
}

// Define kernel before simulation function
__global__ void option_pricing_kernel(
    float* S0, float* K, float* T, float* sigma, float* r, 
    float* call_prices, float* put_prices, 
    float* delta_calls, float* delta_puts,
    float* gammas, float* vegas,
    float* rho_calls, float* rho_puts,
    float* theta_calls, float* theta_puts,
    int num_options) {
    
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < num_options) {
        float s = S0[idx];
        float k = K[idx];
        float t = T[idx];
        float v = sigma[idx];
        float r_val = r[idx];
        
        call_prices[idx] = price_option(s, k, t, v, r_val, OptionType::Call);
        put_prices[idx] = price_option(s, k, t, v, r_val, OptionType::Put);
        delta_calls[idx] = delta(s, k, t, v, r_val, OptionType::Call);
        delta_puts[idx] = delta(s, k, t, v, r_val, OptionType::Put);
        gammas[idx] = gamma(s, k, t, v, r_val);
        vegas[idx] = vega(s, k, t, v, r_val);
        rho_calls[idx] = rho(s, k, t, v, r_val, OptionType::Call);
        rho_puts[idx] = rho(s, k, t, v, r_val, OptionType::Put);
        theta_calls[idx] = theta(s, k, t, v, r_val, OptionType::Call);
        theta_puts[idx] = theta(s, k, t, v, r_val, OptionType::Put);
    }
}

int simulation() {
    int num_simulations = N_SIMULATIONS;
    

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


    // Difference: we have to compute both call and put prices (and greeks for both in case they are needed)
    std::cout << "Computing prices and greeks..." << std::endl;
    
    // Allocate device memory
    float *d_S0, *d_K, *d_T, *d_sigma, *d_r;
    float *d_call_prices, *d_put_prices;
    float *d_delta_calls, *d_delta_puts, *d_gammas, *d_vegas;
    float *d_rho_calls, *d_rho_puts, *d_theta_calls, *d_theta_puts;

    // Allocate and copy input data
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

    cudaMemcpy(d_S0, S0_inputs.data(), num_simulations * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_K, K_inputs.data(), num_simulations * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_T, T_inputs.data(), num_simulations * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_sigma, sigma_inputs.data(), num_simulations * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_r, r_inputs.data(), num_simulations * sizeof(float), cudaMemcpyHostToDevice);

    // Launch kernel
    int blockSize = 256;
    int numBlocks = (num_simulations + blockSize - 1) / blockSize;
    option_pricing_kernel<<<numBlocks, blockSize>>>(
        d_S0, d_K, d_T, d_sigma, d_r,
        d_call_prices, d_put_prices,
        d_delta_calls, d_delta_puts,
        d_gammas, d_vegas,
        d_rho_calls, d_rho_puts,
        d_theta_calls, d_theta_puts,
        num_simulations);

    // Copy results back
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