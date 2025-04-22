# Walkthrough

As required, we value 1 million call and put options plus all the greeks. This is done in parallel using CUDA kernels.

# Modules used

- nvidia
- cuda/11.7

No need to use OpenMP or other parallelizations as this is all done using the GPU

# Build command

`nvcc -O3 assignment_3_solution.cu -o assignment_3_solution`

# Tests

I tried to get a GPU from Midway but I couldn't. So, all the attemps to run the program on Midway gave me an
absurdly low runtime (12 ms). I used my personal GPU to test at it took it around 600-3000 ms. It is a 3060 with 58c. 

I assume the code runtime is OK because the pricing of the tests options had reasonable numbers, used the same functions and the only difference was that the functions were not offloaded to the GPU.

Also tried running a "profiler" but could not read its output