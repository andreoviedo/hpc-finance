#include <vector>
#include <iostream>
#include <chrono>
#include <thread>
#include <omp.h>

using std::vector;
using std::cout;
using std::endl;
using std::thread;

using namespace std::chrono;

typedef vector<vector<int>> matrix;

void matrix_multiply_serial(const matrix& m1, const matrix& m2, matrix& m3,
	int rows, int columns)
{
	for (int i = 0; i < rows; ++i)
	{
		for (int j = 0; j < columns; ++j)
		{
			m3[i][j] = 0;
			for (int k = 0; k < rows; ++k)
			{
				m3[i][j] += m1[i][k] * m2[k][j];
			}
		}
	}
}

void matrix_multiply_parallel(const matrix& m1, const matrix& m2, matrix& m3,
	int rows, int columns)
{
	vector<thread> threads(rows*columns);

	for (int i = 0; i < rows; ++i)
	{
		for (int j = 0; j < columns; ++j)
		{
		    int tid = i*columns + j;	
	            threads[tid] = thread([=, &m3]()
	            {
			m3[i][j] = 0;
			for (int k = 0; k < rows; ++k)
			{
				m3[i][j] += m1[i][k] * m2[k][j];
			}
		    });
	        }
	}

	for (thread& t : threads)
	{
		t.join();
	}
}


void matrix_multiply_parallel_row(const matrix& m1, const matrix& m2, matrix& m3,
	int rows, int columns)
{
	vector<thread> threads(rows);

	for (int i = 0; i < rows; ++i)
	{
		threads[i] = thread([=, &m3]()
		{
			for (int j = 0; j < columns; ++j)
			{
				m3[i][j] = 0;
				for (int k = 0; k < rows; ++k)
				{
					m3[i][j] += m1[i][k] * m2[k][j];
				}
			}
		});
	}

	for (thread& t : threads)
	{
		t.join();
	}
}




int main()
{
    const int rows = 50;
    const int columns = 50;
    matrix m1, m2, m3;

    m1.resize(rows);
    m2.resize(rows);
    m3.resize(rows);

    for (int i = 0; i < rows; ++i)
    {
        m1[i].resize(columns);
        m2[i].resize(columns);
        m3[i].resize(columns);
    }

    //populate matrix 
    for (int i = 0; i < rows; ++i)
    {
        for (int j = 0; j < columns; ++j)
        {
            m1[i][j] = 1;
        }
    }

    //populate matrix
    for (int i = 0; i < rows; ++i)
    {
        for (int j = 0; j < columns; ++j)
        {
            m2[i][j] = 2;
        }
    }

    auto t1 = high_resolution_clock::now();

    matrix_multiply_serial(m1, m2, m3, rows, columns);

    auto t2 = high_resolution_clock::now();

    cout << "(Serial) Time elapsed " << duration_cast<milliseconds>(t2 - t1).count() << " ms" << endl;

    std::this_thread::sleep_for(std::chrono::seconds(3));

    auto t3 = high_resolution_clock::now();

    matrix_multiply_parallel(m1, m2, m3, rows, columns);

    auto t4 = high_resolution_clock::now();

    cout << "(Thread per element)  Time elapsed " << duration_cast<milliseconds>(t4 - t3).count() << " ms" << endl;

    std::this_thread::sleep_for(std::chrono::seconds(3));
    
    auto t5 = high_resolution_clock::now();

    matrix_multiply_parallel_row(m1, m2, m3, rows, columns);

    auto t6 = high_resolution_clock::now();

    cout << "(Thread per row) Time elapsed " << duration_cast<milliseconds>(t6 - t5).count() << " ms" << endl;

}
