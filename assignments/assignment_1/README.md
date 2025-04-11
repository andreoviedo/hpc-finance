# Instructions

There is a Makefile attached which should build the program (tested on Midway and it worked).

Option two is running the .slurm file which first asks for a node/core, builds the file and runs it and it outputs the to a .out file. I tried scripting the sinteractive query for an specific number of cores. I assume that everytime we run std::thread::hardware_concurrency() it gets the total amount of threads on the remote machine rather than the "available" amount of threads (which should come from the sinteractive request). 

## Modules used

- intel

# Explanation

So I used a fork-join procedure to first value 1 million options on a given set of stocks. The number of stocks was set equal to the number of threads availabe (I am still not sure how this compares to the number of threads one gets after asking for cores when doing sinteractive).

After the fork-join, I use a map pattern to find the mean option value for each stock and then reduce it given that each stock has a given weight (equally weighted for now)