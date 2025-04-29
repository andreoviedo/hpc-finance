# Methodology

The usual MC + Black Scholes: use BSM underlying BM to generate NUM_PATH paths, value them using the call formula and the average them to find the price for a given case. Save all output for each stock price and then print the corresponding portfolio value.

Major difference with respect to the old implementations: here we use CUDA and cuRAND to generate the pseudo-random walks of the price
to then value the option given each path.

# Modules used

- cuda/11.7

# GPU request code

sinteractive --partition=gpu --gres=gpu:1 --time=0:30:00 --account=finm32950

# Compile command

nvcc -O3 -lcurand final-exam.cu -o final-exam

# Preliminary results

- On my personal laptop (RTX 3060 67C 55W 6GB VRAM): 1.11 seconds (1124827 microseconds)
- On midway (Tesla V100 42C 250W 16GB VRAM): 1.9 seconds (1962406 microseconds)

# Caveats

To not require GPUs from Midway I decided to write all the code in my personal laptop and THEN try it on Midway. I had to recompile it again in Midway to run because I had the following error when using Midway

./final-exam: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by ./final-exam)
./final-exam: /lib64/libc.so.6: version `GLIBC_2.34' not found (required by ./final-exam)

After compiling it again (on Midway) I got it to run but it ran 0.8 seconds slower. Idk if this is because the GPU is of an older architecture compared to my laptop's or because of some optimization in modern CUDA as my laptop has a newer version (I think).