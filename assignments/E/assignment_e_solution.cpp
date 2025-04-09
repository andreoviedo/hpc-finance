#include <iostream>
#include <chrono>
#include <cmath>  // For sqrt, log, exp, erf
#include <algorithm> // For max
using namespace std::chrono;

#include <random>

std::random_device rd;
std::mt19937 gen(rd());
std::uniform_real_distribution<> dis(0.0, 1.0);

float random_data(float low, float hi){
    float r = (float)rand() / (float)RAND_MAX;
    return low + r * (hi - low);
}


// The "randommess" comes from BM number

float z_i(){
    // Draw a random number from the uniform distribution
    return static_cast<float>(dis(gen));
}

// Normal cumulative distribution function
float norm_cdf(float x) {
    return 0.5f * (1.0f + erf(x / sqrt(2.0f)));
}

// The T argument will hold the randommess in the main function
float european_call_option(float S, float K, float T, float r, float sigma){
    float d1 = (log(S/K) + (r + 0.5 * sigma * sigma) * T) / (sigma * sqrt(T));
    float d2 = d1 - sigma * sqrt(T);
    return S * norm_cdf(d1) - K * exp(-r * T) * norm_cdf(d2);
    
}

// Function to perform the option pricing calculation
void value_option() {
    // Example values
    float S = 100.0f + random_data(-5.0f, 5.0f);  // Stock price
    float K = 100.0f + random_data(-5.0f, 5.0f);  // Strike price
    float T = 1.0f + random_data(-0.5f, 2.0f);    // Time to expiration (1 year)
    float r = 0.05f + random_data(-0.02f, 0.15f);   // Risk-free rate
    float sigma = 0.2f + random_data(-0.15f, 0.40f); // Volatility
        
    float result = european_call_option(S, K, T, r, sigma);
}

float value_option_with_mc(int M) {
    // Example values
    float S = 100.0f + random_data(-5.0f, 5.0f);  // Stock price
    float K = 100.0f + random_data(-5.0f, 5.0f);  // Strike price
    float T = 1.0f + random_data(-0.5f, 2.0f);    // Time to expiration (1 year)
    float r = 0.05f + random_data(-0.02f, 0.15f);   // Risk-free rate
    float sigma = 0.2f + random_data(-0.15f, 0.40f); // Volatility

    float c = 0.0f;

    for(int i = 0; i < M; i++){
        float sim_S_t = S * exp((r - 0.5 * sigma * sigma) * T + sigma * sqrt(T) * z_i());
        float sim_payoff = std::max(0.0f, sim_S_t - K);
        float sim_result = exp(-r * T) * sim_payoff;
        c += sim_result;
    }
    return c / M;
}


int main(){
    int N = 1000000;
    int M = 1000;
    high_resolution_clock::time_point t1 =high_resolution_clock::now();
    for(int i = 0; i < N; i++){
        value_option_with_mc(M);
    }
    high_resolution_clock::time_point t2 =high_resolution_clock::now();
    std::cout << "Elapsed time: " <<duration_cast<milliseconds>(t2 - t1).count() << " ms";
}