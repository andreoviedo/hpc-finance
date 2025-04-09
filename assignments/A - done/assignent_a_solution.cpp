#include <iostream>
#include <chrono>
#include <cmath>  // For sqrt, log, exp, erf

using namespace std::chrono;

float random_data(float low, float hi){
    float r = (float)rand() / (float)RAND_MAX;
    return low + r * (hi - low);
}

// Normal cumulative distribution function
float norm_cdf(float x) {
    return 0.5f * (1.0f + erf(x / sqrt(2.0f)));
}

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

int main(){
    int N = 1000000;
    high_resolution_clock::time_point t1 =high_resolution_clock::now();
    for(int i = 0; i < N; i++){
        value_option();
    }
    high_resolution_clock::time_point t2 =high_resolution_clock::now();
    std::cout << "Elapsed time: " <<duration_cast<milliseconds>(t2 - t1).count() << " ms";
}