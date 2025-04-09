#include <cstdlib>
#include <stdio.h>

void add(float *a,float *b, float *c, float *d, float *e, int N)
{
    for (int i = 0; i < N; ++i)
	a[i] = a[i] + b[i] + c[i] + d[i] + e[i];
} 


int main()
{
	const int N = 8;
	float a[N], b[N], c[N], d[N], e[N];

        add(a, a+1, a+2, d, e, N);

        printf("%f %f %f %f %f %f %f %f\n", a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]);
}
