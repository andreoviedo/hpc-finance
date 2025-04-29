Instructions:

The use of any AI tools (e.g., Copilot, ChatGPT, and similar) is strictly prohibited.
This is an individual assignment; collaboration is not allowed. Please refrain from posting any questions, comments, or materials directly or indirectly related to the course content or this project on the discussion board until the final due date.
If you have any questions, comments, or concerns, please email me directly at chanaka@uchicago.edu. I will evaluate your email and respond accordingly. Please note that neither I nor the TAs will be able to offer assistance during this project. 

Regarding the use of compute nodes on midway:
If you choose to use a GPU, please use only 1 GPU device as demonstrated in class, with the following flag for sinteractive: --gres=gpu:1
Using more than 1 GPU device is not permitted.
Use --cpus-per-task to request a certain number of cores on one computer. Do not use more than one node (computer).

We do not recommend optimizing a program for a specific number of cores. TAs generally test your code on a certain number of cores, which we won't disclose, as we don't anyone to optimize or hard code your code for a specific number of cores.

Do not request additional memory on a compute node (i.e., do not use any flags to specify memory size in the sinteractive command).
This project evaluates your coding abilities. Consequently, using pricing libraries or other external work (downloaded from the Internet or any other source) to complete the primary tasks of this project (option pricing and calculating the value of an option portfolio) is not permitted. You may consult online resources such as documentation and tutorials for assistance, but you are not allowed to use code written by others for the main functions of this project. You may use the libraries discussed in class for parallelization and any standard C++ or Python functionality.
Any books and urls (for online resources) used during the exam should be listed on the exam with the relevant sections (e.g. for books: name of the book and the page numbers).
Please use the technologies and techniques discussed in class (i.e., avoid using any technology not covered). If a student uses features from a technology beyond what was discussed, the instructor or TAs may ask the student to explain their solution thoroughly. All students are expected to be able to articulate the solutions they submit, and explanations are generally requested if material not covered in class is used in assignments or projects.

Write CLEAR code. Use comments to indicate what each function/class does. Define/declare constant values in one place and use them throughout your program. For example, if you use 1000000 (1 million) paths for simulation of an option, define the number of paths at the top of your program (e.g., const int NUM_PATHS = 1000000;) and use NUM_PATHS in our program. 
Failure to adhere to these instructions will result in penalties, including (but not limited to) disqualification from the competition portion of the project.

Problem:

Write code to find the value of an option portfolio consisting of European **call** options using the **Monte Carlo (simulation) technique** and to answer the questions below. Use the **Black-Scholes model**. The sum of the value of each option position determines the value of the portfolio.
Specifically:
The value of an option position = price_of_option * position_size
Value of portfolio                         = sum of all option positions

Regarding Monte Carlo methods, we accept conventional solutions as outlined in Options Futures and Other Derivatives (recommended reference, see syllabus for details), or, any solution taught in finmath (e.g., Finm 32000, Finm 32600). Additionally, we accept methods published in peer-reviewed journals in English, provided the complete paper is attached with your submission.

You may utilize any technology or technologies we have discussed in this course to complete this project. This means both Python and C++ solutions are acceptable. However, the maximum points you can earn depend on the degree of difficulty associated with each technology, as listed below. 

You should use at least 1 million paths to simulate each option price (i.e., paths >= 1 million 

The portfolio consists of **500 options of a stock** (e.g., MSFT), with time to expiration/maturity (T) given by: 0.5, 0.75, 1.0, 1.25, 1.5.  (T in years)

For each T above, we have 100 strikes, starting at 50 and incrementing in steps of 1 (i.e., 50, 51, 52, …, 149).

Initial stock price, S = 100. 

The table below shows the interest rate (r)  and volatility (v) for each T: 

T            rate (r)         volatility (v) 

-----     ---------          ----------------

0.5         0.03               0.30 

0.75       0.04               0.29 

1.0         0.05               0.28 

1.25       0.06               0.27 

1.5         0.07               0.26

The size of each option position is 1 (long). 

Using code you wrote:
a) Simulate the value of the option portfolio (i.e., S = 100)
b) Simulate the value of the option portfolio if the initial stock price (S) moves down from $100 to $95, in steps of $1 decrements (i.e., S=99, 98, 97, 96, 95)
c) Simulate the value of the option portfolio if the initial stock price (S) moves up from $100 to $105, in steps of $1 increments (i.e., S=101, 102, 103, 104, 105)

Write the results (portfolio values) for each case to Console using the format shown below:

Output Format:

The results should show the portfolio values corresponding to each stock (S) price, using the format:
Stock price      Portfolio Value
95                           xxx
….                          ……

100                         xxz
101                         xxz
....                            .....
105                         xyz

Measuring Time:

Measure the time taken to run your program from start to finish, excluding the times to initialize and input data on the CPU and write the portfolio values to Console. C++ users: use chrono for time measurements (C++); Python users: use time module.  Show the time to price the portfolio and the scenarios in milliseconds (ms), as shown below:

Populate input data on the CPU

Allocate memory on the GPU (if a GPU is used)

t1 = time now

Copy data to GPU (if a GPU is used)

Compute initial portfolio value and the values under each scenario.

Obtain the values in CPU memory, so that they can be directly used on the CPU. This includes copying the results back to the CPU if a GPU is used.

t2 = time now 

elapsed time = t2 - t1 (us)

Measure the time at two designated points as illustrated above. It is not acceptable to measure times for multiple sections and sum them, as this can cause confusion and lead to potentially misleading results, whether intentional or unintentional.