#include <cassert>

#include <iostream>
#include <string>
#include <string_view>

using namespace std;

void assert_test()
{
	const int x = 5;

	assert(x == 10); 

	//static_assert(x == 10, "this is checked at compile time!!");
}
 
constexpr int square(int x)
{
	return x * x;
}

void test_square()
{
	constexpr int x = 5;

	static_assert(square(x) == 25, "incorrect value found at compile time");
}

constexpr int fib(const int n)
{
	switch (n)
	{
		case 0: return 0;
		case 1: return 1;
		default: return fib(n - 1) + fib(n - 2);
	}
}

void fibonacci_test()
{
        const int fib13 = fib(13);

	static_assert(fib13 == 233, "incorrect value, checking value at compile time!");
}

void* operator new(size_t n)
{
	cout << "allocating new memory using malloc: " << n << endl;
	return malloc(n);
}

void string_test()
{
	string str = "009eY0	ZBZX  990101C00015000	VIX	32	FALSE";

	string osi = str.substr(7, 21);

	cout << osi << endl;
}

void string_view_test()
{
	string_view str = "009eY0	ZBZX  990101C00015000	VIX	32	FALSE";

	string_view osi = str.substr(7, 21);

	cout << osi << endl;

}


int main()
{
	//assert_test();

	//test_square();

	//fibonacci_test();

	//string_test();

	string_view_test();

}
