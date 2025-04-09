#include <tbb/task_group.h>
#include <iostream>

class ThreadTask
{
  private:
    int threadID_;
  public:
    ThreadTask(int id)
       : threadID_(id)
    {}
   
   void operator()() const
   {
      std::cout << "Hello, World, " << threadID_ << std::endl;
   }
};

int main()
{
    const int NumTasks = 10;
    tbb::task_group group;

    for (int i = 0; i < NumTasks; ++i)
    {
       group.run(ThreadTask(i));
    }
    group.wait();
}
