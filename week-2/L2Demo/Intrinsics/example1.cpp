#include <xmmintrin.h> // for SSE

#include <stdio.h> //for printf

void example1()
{
    __m128 a = _mm_set_ps(1.0f, 2.0f, 3.0f, 4.0f);
    __m128 b = _mm_set_ps(5.0f, 6.0f, 7.0f, 8.0f);
    
    __m128 c = _mm_add_ps(a, b);

    float* f = (float*)&c;
    printf("%f %f %f %f\n", f[3], f[2], f[1], f[0]);
}

int main()
{
    example1();
}
