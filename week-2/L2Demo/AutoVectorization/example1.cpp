#include <cstdlib>
#include <stdio.h>

int main()
{
   const int N = 8;
   float a[N]{1, 2, 3, 4, 5, 6, 7, 8}; 
   float b[N]{11, 12, 13, 14, 15, 16, 17, 18};
   float c[N];

   for (int i = 0; i < N; ++i)
      c[i] = a[i] + b[i];

   printf("%f %f %f %f %f %f %f %f", c[0], c[1], c[2], c[3], c[4], c[5], c[6], c[7]);
}
