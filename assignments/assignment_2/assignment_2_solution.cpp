#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>
#include <random>
#include <omp.h>
#include <iomanip>
#include <chrono>

// Let's parallelize the random number generation
// #include <mkl.h>
// #include <mkl_vsl.h>
// NO need to use MKL (at least for this assignment)


using namespace std::chrono;
// Required bash commands:

// module load intel
// module use /software/intel/oneapi_hpc_2022.1/modulefiles
// module load vtune/latest

// sinteractive --time=0:30:0 --cpus-per-task=8 --account=finm32950

// For MKL

// module use /software/intel/oneapi_hpc_2022.1/modulefiles
// module load intel/2022.0
// module load mkl/latest


// For vectorization report

// icc -qopt-report=1 -O2 assignment_2_solution.cpp -o assignment_2_solution

#define PROB_UP 0.5
#define PROB_DOWN 0.5

float random_data(float low, float hi)
{
    float r = (float)rand()/(float)RAND_MAX;
    return low + r*(hi-low);
}

// No need to add the cdf calculation here because its either 1 or -1.

// --- Binomial Tree Node Structure --- (REMOVED - No longer needed)
// struct BinomialNode {
//     double assetPrice = 0.0;
//     double optionValue = 0.0;
// };

// The logic is as follows:
// We need to generate the last "leaves" of the tree. We created the tree structure for the
// last step. The first step is to generate the asset prices for the last step

// Nope. We will not use the tree structure, we can just use a vector and replace the option value

// One question I have here is that becaus we are using pragma for each 1 of 1 million simulations,
// it means that I cannot parallelize the generation of the last step, right?

// Maybe I can vectorize this?

std::vector<float> generateLastStep(
    float S0, float T, int N, float sigma, float r)
{   
    float dt = T / static_cast<float>(N);
    float sqrt_dt = std::sqrt(dt);
    float drift = r - 0.5f * sigma * sigma;
    float u = std::exp(drift * dt + sigma * sqrt_dt);
    float d = std::exp(drift * dt - sigma * sqrt_dt);
    std::vector<float> finalAssetPrices(N + 1);

    // Vectorize this? Hopefully

    for (int j = 0; j <= N; ++j) {
        finalAssetPrices[j] = S0 * std::pow(u, j) * std::pow(d, N - j);
    }
    return finalAssetPrices;
}

// Define Option Type to make it easier to change the option type
enum class OptionType {
    Call,
    Put
};

// Function to price a European option using backward induction
// I think this is the most memory-optimized version of the code after some testing

float priceEuropeanOption(
    float S0, float K, float T, int N, float sigma, float r,
    OptionType optionType)
{
    float dt = T / static_cast<float>(N);
    float p = PROB_UP;
    float q = PROB_DOWN;
    float discountFactor = std::exp(-r * dt);

    std::vector<float> finalAssetPrices = generateLastStep(S0, T, N, sigma, r);
    std::vector<float> optionValues(N + 1);
    
    int lastStep = N;
    // Parallelize this?
    #pragma omp parallel for schedule(static)
    for (int j = 0; j <= lastStep; ++j) {
        float assetPriceAtExpiry = finalAssetPrices[j];
        if (optionType == OptionType::Call) {
            optionValues[j] = std::max(0.0f, assetPriceAtExpiry - K);
        } else {
            optionValues[j] = std::max(0.0f, K - assetPriceAtExpiry);
        }
    }

    // Parallelize this?
    //#pragma omp parallel for schedule(static)

    // FOR SOME REASON this just makes the tests not work.
    // I guess its because we are "replacing" values in the vector
    for (int i = N - 1; i >= 0; --i) {
        for (int j = 0; j <= i; ++j) {
            optionValues[j] = discountFactor * (p * optionValues[j + 1] + q * optionValues[j]);
        }
    }
    return optionValues[0];
}

// Part 1: the tests

int tests() {
    float S0_a = 90.0f;
    float K = 100.0f;
    float r = 0.03f;
    float sigma = 0.3f;
    float T = 1.0f;
    int N = 1000;

    float callPrice_a = priceEuropeanOption(S0_a, K, T, N, sigma, r, OptionType::Call);
    float putPrice_a = priceEuropeanOption(S0_a, K, T, N, sigma, r, OptionType::Put);
    
    std::cout << "a) S = 90: Call = " << callPrice_a << ", Put = " << putPrice_a << std::endl;
    
    float S0_b = 95.0f;
    float callPrice_b = priceEuropeanOption(S0_b, K, T, N, sigma, r, OptionType::Call);
    float putPrice_b = priceEuropeanOption(S0_b, K, T, N, sigma, r, OptionType::Put);
    std::cout << "b) S = 95: Call = " << callPrice_b << ", Put = " << putPrice_b << std::endl;
    
    float S0_c = 100.0f;
    float callPrice_c = priceEuropeanOption(S0_c, K, T, N, sigma, r, OptionType::Call);
    float putPrice_c = priceEuropeanOption(S0_c, K, T, N, sigma, r, OptionType::Put);
    std::cout << "c) S = 100: Call = " << callPrice_c << ", Put = " << putPrice_c << std::endl;
    
    float S0_d = 105.0f;
    float callPrice_d = priceEuropeanOption(S0_d, K, T, N, sigma, r, OptionType::Call);
    float putPrice_d = priceEuropeanOption(S0_d, K, T, N, sigma, r, OptionType::Put);
    std::cout << "d) S = 105: Call = " << callPrice_d << ", Put = " << putPrice_d << std::endl;
    
    float S0_e = 110.0f;
    float callPrice_e = priceEuropeanOption(S0_e, K, T, N, sigma, r, OptionType::Call);
    float putPrice_e = priceEuropeanOption(S0_e, K, T, N, sigma, r, OptionType::Put);
    std::cout << "e) S = 110: Call = " << callPrice_e << ", Put = " << putPrice_e << std::endl;
    
    
    return 0;
}

// Part 2: the simulation
// Kind of a log of the modifications I made to the code to get improved time performance
// as there is no track of the changes

// 1. DONE: Do I actually need the tree structure? Mayeb for the option value but not for the asset price. Only calculate the asset price for the last step.
// 2. DONE: Change to floats
// 3. DONE: Revise how to use vectorization to generate the million different arguments
// 4. DONE: Parallelize the code: check all loops for the possibility of parallelization
// 5. DONE: It seems like it will be VERY hard to parallelize the backward induction part. Well yes it would give us an incorrect result.

int simulation() {
    int num_simulations = 1000000;
    int N_steps = 1000;

    std::vector<float> S0_inputs(num_simulations);
    std::vector<float> K_inputs(num_simulations);
    std::vector<float> T_inputs(num_simulations);
    std::vector<float> sigma_inputs(num_simulations);
    std::vector<float> r_inputs(num_simulations);
    std::vector<float> results(num_simulations);
    std::vector<float> N_steps_inputs(num_simulations);
    // Would N also need to be randomized? Doesn't add much to the computation time tbh.

    // Populate the vectors with random data using the original loop No need to use MKL
    for (long long i = 0; i < num_simulations; ++i) {
        S0_inputs[i] = random_data(80.0f, 120.0f);
        K_inputs[i] = random_data(80.0f, 120.0f);
        T_inputs[i] = random_data(0.1f, 2.0f);
        sigma_inputs[i] = random_data(0.05f, 0.5f);
        r_inputs[i] = random_data(0.0f, 0.1f);
        N_steps_inputs[i] = random_data(1000, 10000);
    }

    high_resolution_clock::time_point t1 = high_resolution_clock::now();

    #pragma omp parallel for schedule(static)
    for (long long i = 0; i < num_simulations; ++i) {
        results[i] = priceEuropeanOption(
            S0_inputs[i], K_inputs[i], T_inputs[i], N_steps,
            sigma_inputs[i], r_inputs[i], OptionType::Call
        );
    }
    high_resolution_clock::time_point t2 = high_resolution_clock::now();

    std::cout << "Elapsed time: " << duration_cast<milliseconds>(t2-t1).count() << " milliseconds" << std::endl;
    return 0;
}


int main() {
    tests(); // Correct value for each part and option type
    simulation(); // Not checked for correctness
    return 0;
}

// icc -O2 -qopenmp -qmkl assignment_2_solution.cpp -o assignment_2


// vtune code

// vtune -collect hotspots -result-dir vtune_hotspots -- ./assignment_2
// vtune -collect threading -result-dir vtune_threading -- ./assignment_2