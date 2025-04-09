#include <iostream>
#include <thread>

int main()
{
   std::thread t([]()
   {
       std::cout << "Hello, world" << std::endl;
   }); 

   t.join();
}
