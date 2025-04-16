# Walkthrough

Most of the code is commented. The code has two main steps:

1. Generate the final asset prices for t=T given the N steps chosen
2. Calculate the option price at t = 0 using backward induction

This program was compiled using -O3 for vectorization (and checked that loops were vectorized), OpenMP for parallelization for **some** loops. I thought of using MKL for the random number generation for the simulations but afaik the data generation time is outside of the reported time.

The main function first runs (and outputs) the pricing of 5 dummy options to check for the correctness of the pricer. After that, the pricer is used to price 1 million call options with random inputs. The random inputs are stored in a vector previous to the timing of the pricing of the 1 million options.

The type of tree used is the same as the one proposed in the assignment: a Jarrow-Rudd tree with 0.5 prob of up and down scenarios.

# Modules needed

- To compile:
    - intel
    - vtune (for profiling)
    - MKL (tried to do something)

# Results

Using 8 cpus per task the code run in around 14.7 seconds and it seems to linearly scale with the amount of threads (couldn't try using more than 12 cores)