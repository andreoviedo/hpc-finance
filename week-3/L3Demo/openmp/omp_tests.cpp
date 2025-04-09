#include <omp.h>
#include <iostream>
#include <chrono>
#include <thread>


using namespace std;

void static_scheduling_test()
{
	#pragma omp parallel for schedule(static) num_threads(4)
	for (int i = 0; i < 16; ++i)
	{
		if (i < 2)
		{
			std::this_thread::sleep_for(std::chrono::milliseconds(2000)); // simulate long work
		}
		else
		{
			std::this_thread::sleep_for(std::chrono::milliseconds(100)); // simulate short work
		}
		#pragma omp critical
		cout << "(" << omp_get_thread_num()
			<< ":" << i << ")" << flush;
	}
}

void dynamic_scheduling_test()
{
	#pragma omp parallel for schedule(dynamic) num_threads(4)
	for (int i = 0; i < 16; ++i)
	{
		if (i < 2)
		{
			std::this_thread::sleep_for(std::chrono::milliseconds(2000)); // simulate long work
		}
		else
		{
			std::this_thread::sleep_for(std::chrono::milliseconds(100)); // simulate short work
		}
		#pragma omp critical
		cout << "(" << omp_get_thread_num()
			<< ":" << i << ")" << flush;
	}
}

void reduction_test()
{
	int sum_sq = 0;
	#pragma omp parallel for reduction(+:sum_sq)
	for (int i = 0; i < 10; ++i)
	{
		sum_sq += i * i;
	}
	std::cout << sum_sq << std::endl;
}

void atomic_test()
{
	unsigned long counter = 0;
	int N = 10;

	#pragma omp parallel for 
	for (int j = 0; j < N; ++j)
	{
		for (int i = 0; i < 100000; ++i)
		{
			#pragma omp atomic 
			counter++;
		}
	}

	cout << counter << endl;
}


void scheduling_test()
{
	using namespace std::chrono;
	std::cout << "Running Static Scheduling Test " << std::endl;
	auto t1 = high_resolution_clock::now();

	static_scheduling_test();
	auto t2 = high_resolution_clock::now();

	std::cout << "\nStatic Scheduling Test: Elapsed Time: " << duration_cast<milliseconds>(t2 - t1).count() << std::endl;

	std::this_thread::sleep_for(std::chrono::milliseconds(1000)); 
	
	std::cout << "Running Dynamic Scheduling Test " << std::endl;
	auto t3 = high_resolution_clock::now();
	dynamic_scheduling_test();
	auto t4 = high_resolution_clock::now();

	std::cout << "\nDynamic Scheduling Test: Elapsed Time: " << duration_cast<milliseconds>(t4 - t3).count() << std::endl;
	
}


int main() 
{
        scheduling_test();
       	
	//reduction_test();

	//atomic_test();
}
