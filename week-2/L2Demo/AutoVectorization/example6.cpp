#include <cstdlib>
#include <stdio.h>

int main()
{
	const int N = 8;
        int i= 0;
        int a[N], b[N];

        while (i<N)
        {
		a[i] = a[i] * b[i];

                if (a[i] < 2) break;
             
                ++i;
        }

}
