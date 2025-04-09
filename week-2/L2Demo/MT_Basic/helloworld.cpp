#include <iostream>
#include <thread>

void Greeting()
{
   std::cout << "Hello, world" << std::endl;
}


int main()
{
   std::thread t(Greeting);

   t.join();
}
