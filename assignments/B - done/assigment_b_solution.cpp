#include <iostream>
#include <chrono>
#include <cmath>  // For sqrt, log, exp, erf
#include <vector>

typedef std::vector<std::vector<float>> matrix;

using namespace std::chrono;

float random_data(float low, float hi){
    float r = (float)rand() / (float)RAND_MAX;
    return low + r * (hi - low);
}

// Function to multiply two NxN matrices
matrix matrix_multiply(const matrix& A, const matrix& B) {
    int N = A.size();
    matrix result(N, std::vector<float>(N, 0.0f));
    
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            for (int k = 0; k < N; k++) {
                result[i][j] += A[i][k] * B[k][j];
            }
        }
    }
    return result;
}

int main(){
    const int N = 1000;  // Matrix size NxN

    // Initialize first matrix
    matrix m1;
    matrix m2;


    m1.resize(N);
    m2.resize(N);
    for (int i = 0; i < N; ++i){ 
        m1[i].resize(N);
        m2[i].resize(N);
    }

    // Populate both matrices with random values - Not part of the chrono timing?

    for (int i = 0; i < N; ++i){
        for (int j = 0; j < N; ++j){ 
            m1[i][j] = random_data(0, 10);
            m2[i][j] = random_data(0, 10);
        }
    }

    high_resolution_clock::time_point t1 = high_resolution_clock::now();
    
    // Perform matrix multiplication
    matrix result = matrix_multiply(m1, m2);
    
    high_resolution_clock::time_point t2 = high_resolution_clock::now();

    std::cout << "Elapsed time: " <<duration_cast<milliseconds>(t2 - t1).count() << " ms";
    return 0;
}