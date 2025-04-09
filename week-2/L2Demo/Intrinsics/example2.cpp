#include <immintrin.h> // for AVX2

#include <stdio.h> //for printf

void example2()
{
	__m256 a = _mm256_set_ps(1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f);
	__m256 b = _mm256_set_ps(1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f);
	__m256 c = _mm256_set_ps(1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f);

	__m256 d = _mm256_fmadd_ps(a, b, c);

	float* f = (float*)&d;
	printf("%f %f %f %f %f %f %f %f\n", f[7], f[6], f[5], f[4], f[3], f[2], f[1], f[0]);
}

int main()
{
    example2();
}
