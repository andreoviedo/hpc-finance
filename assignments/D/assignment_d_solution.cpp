#include <iostream>
#include <random>
#include <chrono>

double estimate_pi(int N) {
    // Create random number generator
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> dis(-1.0, 1.0);
    
    int points_inside = 0;
    
    for (int i = 0; i < N; ++i) {
        // Generate random point (x, y)
        double x = dis(gen);
        double y = dis(gen);
        
        // Check if point is inside the circle (x^2 + y^2 <= 1)
        if (x*x + y*y <= 1.0) {
            points_inside++;
        }
    }
    
    // Calculate π estimate: π = 4 * (points_inside / total_points)
    return 4.0 * static_cast<double>(points_inside) / N;
}

int main() {
    const int N_values[] = {100, 1000, 10000};
    
    std::cout << "Monte Carlo π Estimation\n";
    std::cout << "=======================\n\n";
    
    for (int N : N_values) {
        auto start = std::chrono::high_resolution_clock::now();
        
        double pi_estimate = estimate_pi(N);
        
        auto end = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
        
        std::cout << "N = " << N << "\n";
        std::cout << "Estimated π = " << pi_estimate << "\n";
        std::cout << "Time taken = " << duration.count() << " ms\n";
        std::cout << "-----------------------\n";
    }
    
    return 0;
}
