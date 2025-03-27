#include <cmath>
#include <chrono>
#include <iostream>

float cdf_normal(const float x)
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


void call_price(float* S0, float *K, float *T, float* v, 
    float* r, float* C, int NumOptions)
{
    for (int i = 0; i < NumOptions; ++i)
    {
        float d1 = 
            (log(S0[i] / K[i]) + (r[i] + 0.5*v[i] * v[i]) * T[i]) / (v[i] * sqrt(T[i]));
        float d2 = 
            (log(S0[i] / K[i]) + (r[i] - 0.5*v[i] * v[i]) * T[i]) / (v[i] * sqrt(T[i]));

        float nd1 = cdf_normal(d1);
        float nd2 = cdf_normal(d2);

        C[i] = S0[i] * nd1 - K[i] * exp(-r[i] * T[i])*nd2;
    }
}

//----------------------------------------------------------------------------
// Generate random data between specified values
//----------------------------------------------------------------------------
float random_data(float low, float hi)
{
    float r = (float)rand() / (float)RAND_MAX;
    return low + r * (hi - low);
}

int main()
{
	static const int N = 1000000;

	float* S = new float[N];
	float* K = new float[N];
	float* v = new float[N];
	float* r = new float[N];
	float* T = new float[N];
	float* C = new float[N];

	for (int i = 0; i < N; ++i)
	{
		S[i] = random_data(0.0f, 200.0f);
		K[i] = random_data(50.0f, 150.0f);
		v[i] = random_data(0.01f, 0.99f);
		r[i] = random_data(0.01f, 0.9f);
		T[i] = random_data(0.01f, 2.0f);

		C[i] = 0.0f;
	}

	using namespace std::chrono;
	auto t1 = high_resolution_clock::now();

	call_price(S, K, T, v, r, C, N);

	auto t2 = high_resolution_clock::now();

	std::cout << "Elapsed Time: " <<
		duration_cast<milliseconds>(t2 - t1).count() <<
		" ms" << std::endl;

}
