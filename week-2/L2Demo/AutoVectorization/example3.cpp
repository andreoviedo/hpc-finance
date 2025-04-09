#include <stdio.h>
#include <cstdlib>

int main()
{
	const int N = 8;
	float a[N], b[N], c[N];

	for (int i=0; i<N; ++i)
	{
		a[i] = rand() % 100;
		b[i] = rand() % 100;
	}
	
	for (int i = 0; i < N; ++i)
		c[i] = a[i] + b[i];
   
  	printf("%f\n", c[0]);
}
