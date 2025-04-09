#include <mkl_vsl.h>
#include <tbb/task_group.h>
#include <tbb/tick_count.h>

#include <iostream>

class PiCalculator 
{
public:
    const long num_points_;
    long& count_points_in_circle_;

    VSLStreamStatePtr stream_;

    PiCalculator(long numpoints, VSLStreamStatePtr stream, long& in)
        : num_points_(numpoints), stream_(stream), count_points_in_circle_(in)
    {
        count_points_in_circle_ = 0; // make sure to initialize to zero.
    }

    void operator()() const //has to be const
    {
        //We need to represent random points given by num_points_ (e.g. 1000)
        //Each point needs two random (x, y) coordinates 
	//Here we're generationg all random numbers using one call.
	//What are the drawback?
	//How can you address that drawback?
        const int block_size = num_points_ * 2; 
    
        double rands[block_size]; //We have e.g. 2000 random numbers 
        
        vdRngUniform(VSL_RNG_METHOD_UNIFORM_STD, 
			stream_, 
			block_size,  
			rands, 
			-1.0, 1.0); //range [-1,1]
	for (int i = 0; i < num_points_; ++i) 
        {
            double x = rands[2*i];
            double y = rands[2*i+1];
            if (x * x + y * y <= 1.0) ++(count_points_in_circle_);
        }
    }
};


int main() 
{
    int errorcode;
    //we devide simulations among 50 tasks
    const unsigned long tasks = 50;
    const unsigned long samples_per_task = 1000l;
    int seed = 777;

    VSLStreamStatePtr stream[tasks];

    for (int i = 0; i < tasks; i++) 
    {
        errorcode = vslNewStream(&stream[i], VSL_BRNG_MCG59, seed);
        if (errorcode) return 1;

        errorcode = vslLeapfrogStream(stream[i], i, tasks);

        if (errorcode) return 1;
    }

    tbb::task_group group;
    long results[tasks];
   
    tbb::tick_count t0 = tbb::tick_count::now();

    for (int i = 0; i < tasks; i++) 
    {
        group.run(PiCalculator(samples_per_task, stream[i], results[i]));
    }

    group.wait();

    unsigned long total_num_points_inside_circle = 0ul;

    for (int i = 0; i < tasks; i++)
    {
	total_num_points_inside_circle += results[i];
    }


    tbb::tick_count t1 = tbb::tick_count::now();

    std::cout << "pi = " << 4.0 * total_num_points_inside_circle / (tasks * samples_per_task) << std::endl;

    std::cout << "time: " << (t1 - t0).seconds() << " seconds " << std::endl;

    for (int i = 0; i < tasks; i++)
    {
        vslDeleteStream(&stream[i]);
    }
}

