//Barriers to Vectorization: Example 1
#include <cstdlib>
#include <stdio.h>

int main()
{
	const int N = 8;
	float a[N], b[N], c[N];

	for (int i = 0; i < N; ++i)
	   if(i>3) c[i] = a[i] + b[i] + c[i-1];

        printf("%f %f %f %f %f %f %f %f\n", c[0], c[1], c[2], c[3], c[4], c[5], c[6], c[7]);

}
