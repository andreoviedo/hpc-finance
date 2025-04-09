#include <stdio.h>

const int ROWS = 1024*12;
const int COLS = 1024*12;
unsigned int data[ROWS][COLS];

int main()
{
   int sum = 0;

   for (int row = 0; row < ROWS; ++row)
   {
      for (int col = 0; col < COLS; ++col)
      {
          data[row][col] = row + col;
      }
   }

   for (int row = 0; row < ROWS; ++row)
   {
      for (int col = 0; col < COLS; ++col)
      {
         sum += data[row][col] + data[col][row];
      }
   }

   printf("%d\n", sum);
}
