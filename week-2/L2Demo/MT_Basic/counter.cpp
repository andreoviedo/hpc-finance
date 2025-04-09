#include <iostream>
#include <vector>
#include <thread>
#include <mutex>
#include <atomic>

using namespace std;

void test1()
{
	unsigned long counter = 0;
	int N = 10;

	for (int j = 0; j < N; ++j)
	{
		for (int i = 0; i < 100000; ++i)
		{
			counter++;
		}
	}

	cout << counter << endl;
}

void test2()
{
	unsigned long counter = 0;
	int numThreads = 10;

	vector<thread> threads(numThreads);
	for (int j = 0; j < numThreads; ++j)
	{
		threads[j] = thread([&counter]()
		{
			for (int i = 0; i < 100000; ++i)
			{
				counter++;
			}
		});
	}
	for (thread& t : threads) 
		t.join();

	cout << counter << endl;
}

void test3()
{
	unsigned long counter = 0;
	int numThreads = 10;
        mutex m;

	vector<thread> threads(numThreads);
	for (int j = 0; j < numThreads; ++j)
	{
		threads[j] = thread([&m, &counter]()
		{
			for (int i = 0; i < 100000; ++i)
			{
                                m.lock();
				counter++;
                                m.unlock();
			}
		});
	}
	for (thread& t : threads) 
		t.join();

	cout << counter << endl;
}

void test4()
{
	unsigned long counter = 0;
	int numThreads = 10;
        mutex m;

	vector<thread> threads(numThreads);
	for (int j = 0; j < numThreads; ++j)
	{
		threads[j] = thread([&m, &counter]()
		{
			for (int i = 0; i < 100000; ++i)
			{
                                std::lock_guard<std::mutex> guard(m);
				counter++;
			}
		});
	}
	for (thread& t : threads) 
		t.join();

	cout << counter << endl;
}


int test5()
{
	std::atomic<unsigned long> counter;
	counter = 0;
	int numThreads = 10;
	
	vector<thread> threads(numThreads);
	for (int j = 0; j < numThreads; ++j)
	{
		threads[j] = thread([&]()
		{
			for (int i = 0; i < 100000; ++i)
			{
				counter++;
			}
		});
	}
	for (thread& t : threads) 
		t.join();

	cout << counter << endl;
}


int main()
{
   test5();
}
