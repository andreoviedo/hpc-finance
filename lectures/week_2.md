# FINM 32950: Intro to HPC in Finance - Lecture 2

**Instructor:** Chanaka Liyanarachchi
**Date:** March 31, 2025

## Introduction

This lecture covers two main topics crucial for High-Performance Computing (HPC) in finance:

1.  **Vectorization:** Techniques to perform the same operation on multiple data points simultaneously using specialized CPU instructions.
2.  **Using Multicore Nodes:** Leveraging multiple CPU cores within a single compute node through parallel programming, specifically multithreading.

---

## Vectorization

### Vectorization in Action

*   **Recap:** Last week, we introduced the concept of vectorization.
*   **Today:** We will explore how vectorization works using concrete examples.

There are two primary ways to achieve vectorization:

1.  **Using Intrinsics:** Employing low-level functions built directly into the compiler¹. These functions map closely to specific CPU vector instructions.
2.  **Auto-vectorization:** Relying on the compiler to automatically convert high-level language constructs (like loops) into vector instructions.

While intrinsics offer fine-grained control and demonstrate the power of vectorization effectively, we will **not** use them directly for programming tasks in this course. Their primary use here is for demonstration and understanding *how* vectorization operates at a low level.

In this course, we **prefer auto-vectorization**. The reasons for this preference (readability, portability, maintainability) will become clearer as we proceed.

¹ *Reference: [Microsoft Compiler Intrinsics](https://docs.microsoft.com/en-us/cpp/intrinsics/compiler-intrinsics?view=vs-2019)*

### Representing Packed Data

*   Standard C++ data types (`int`, `double`, `float`, `short`, etc.) represent single data items.
*   To store multiple data items that can be processed in parallel (packed data), we cannot use these fundamental types directly.
*   We need **vector extension types**. These types correspond to the vector registers available on the CPU.
*   The number of data items that can fit into a packed register depends on:
    *   **Register Size:** Modern CPUs have registers of varying sizes (e.g., 128-bit, 256-bit, 512-bit).
    *   **Fundamental Data Type Size:** The size of the individual data items (e.g., `float` is 32 bits, `double` is 64 bits).

*   **Examples:**
    *   A 128-bit register can store: 4 `float`s (4 * 32 = 128) or 2 `double`s (2 * 64 = 128).
    *   A 256-bit register can store: 8 `float`s (8 * 32 = 256) or 4 `double`s (4 * 64 = 256).

*   Vector extension types depend on:
    1.  **Architecture/Register Size:** Different instruction set extensions use different register sizes (SSE2: 128-bit, AVX2: 256-bit, AVX-512: 512-bit).
    2.  **Fundamental Data Type:** The type of data being packed (e.g., `float`: 32-bit, `double`: 64-bit).

### Packed Data Types (Intel Intrinsics Naming)

Intel intrinsics use specific types to represent packed data:

*   **For 128-bit registers (SSE):**
    *   `__m128`: Stores 4 `float`s.
    *   `__m128d`: Stores 2 `double`s.
    *   `__m128i`: Stores integers (e.g., 4 x 32-bit `int`s, 8 x 16-bit `short`s, 16 x 8-bit `char`s).
    *   ... (other integer variations)
*   **For 256-bit registers (AVX):**
    *   `__m256`: Stores 8 `float`s.
    *   `__m256d`: Stores 4 `double`s.
    *   `__m256i`: Stores integers (e.g., 8 x 32-bit `int`s, 16 x 16-bit `short`s).
    *   ... (other integer variations)

**Naming Pattern:**

*   Prefix: `__m`
*   Register Size: `128`, `256`, `512`
*   Data Type Suffix:
    *   `d`: `double`
    *   `i`: integer types
    *   (none): `float` (default)
    *   ... (other specific suffixes exist)

### Operations on Packed Data

*   Standard arithmetic operators (`+`, `-`, `*`, `/`) cannot be used directly with packed data types.
*   We must use **intrinsic functions**, which correspond to specific CPU vector instructions (packed instructions).
*   Intrinsics provide a *family of functions* for each logical operation (e.g., addition), tailored to different packed data types and sizes.

*   **Example (SSE2 - 128-bit):**
    *   `_mm_add_epi32`: Adds packed 32-bit integers (4 elements).
    *   `_mm_add_epi16`: Adds packed 16-bit integers (8 elements).
    *   ...
*   **Example (AVX2 - 256-bit):**
    *   `_mm256_add_epi32`: Adds packed 32-bit integers (8 elements).
    *   `_mm256_add_epi16`: Adds packed 16-bit integers (16 elements).
    *   ...

*   *Reference: [Intel Intrinsics Guide](https://software.intel.com/sites/landingpage/IntrinsicsGuide/#=undefined)*

### Intrinsics: Example 1 (SSE Float Addition)

This example shows adding two packed vectors of four floats using SSE intrinsics.

```cpp
#include <xmmintrin.h> // for SSE intrinsics
#include <stdio.h>     // for printf

void add_test() {
    // Initialize two 128-bit registers with 4 floats each.
    // Note: _mm_set_ps arguments are in reverse order in memory.
    __m128 a = _mm_set_ps(4.0f, 3.0f, 2.0f, 1.0f); // a = [1.0f, 2.0f, 3.0f, 4.0f]
    __m128 b = _mm_set_ps(8.0f, 7.0f, 6.0f, 5.0f); // b = [5.0f, 6.0f, 7.0f, 8.0f]

    // Perform packed single-precision addition (a + b)
    __m128 c = _mm_add_ps(a, b); // c = [6.0f, 8.0f, 10.0f, 12.0f]

    // Displaying results requires casting to access individual floats
    float* f = (float*)&c;
    printf("%f %f %f %f\n", f[0], f[1], f[2], f[3]);
    // Output: 6.000000 8.000000 10.000000 12.000000
}
```

### Intrinsics: Example 2 (Fused Multiply-Add)

Let's illustrate the power of vectorization with a fused multiply-add (FMA) operation. Consider this scalar loop:

```cpp
// Computes d[i] = a[i] * b[i] + c[i] for i = 0 to 15
for (int i=0; i<16; i++) {
    d[i] = a[i] * b[i] + c[i];
}
```

This loop performs 16 multiplications and 16 additions.

Using AVX-512 intrinsics (assuming `a`, `b`, `c`, `d` are arrays of `float`s and the CPU supports AVX-512F), we can potentially do this in a single instruction for 16 floats:

```cpp
// Assume a_packed, b_packed, c_packed are __m512 types loaded with data
// from arrays a, b, c respectively.

__m512 a_packed = /* load 16 floats from a */ ;
__m512 b_packed = /* load 16 floats from b */ ;
__m512 c_packed = /* load 16 floats from c */ ;

// Perform packed Fused Multiply-Add: (a * b) + c
__m512 d_packed = _mm512_fmadd_ps(a_packed, b_packed, c_packed);

// Store results from d_packed back to array d
/* store 16 floats to d */ ;
```

This single intrinsic `_mm512_fmadd_ps` performs 16 multiplications and 16 additions much faster than the scalar loop.

### Vectorization using Intrinsics: Advantages and Disadvantages

*   **Recap:** We briefly looked at intrinsics to show:
    1.  How vectorization works at a low level.
    2.  The potential benefits and power of vectorization.

*   **Drawbacks of Intrinsics:**
    *   **Complexity:** Code using intrinsics is difficult to read, write, and maintain (imagine writing a Black-Scholes pricer this way).
    *   **Portability:** Intrinsics are specific to CPU architectures (SSE, AVX, AVX-512, NEON, etc.) and compilers. Code written for one may not work on another.

*   **Next:** We will now focus on achieving vectorization using high-level programming constructs via **auto-vectorization**.

---

### Auto-Vectorization

*   Modern compilers can often **automatically** detect opportunities for vectorization in standard code (especially loops) and generate the appropriate packed SIMD instructions. This is called **auto-vectorization**.
*   **How it works:** The compiler analyzes loops and replaces them with equivalent, faster vector instructions where possible and safe.

*   **Requirements for Auto-vectorization:**
    *   The code (primarily loops) must satisfy certain criteria (e.g., countable iterations, no complex control flow, no non-vectorizable function calls, specific types of data dependencies).
    *   Sometimes, compiler directives (like pragmas) are needed to guide, encourage, or force the compiler to vectorize.

*   **Understanding Auto-vectorization:** We need to understand:
    *   How to check *if* the compiler successfully auto-vectorized a loop.
    *   If not, *why* the compiler decided not to vectorize (e.g., data dependencies, function calls, profitability).
    *   How to modify the code or use directives to *enable* or *improve* auto-vectorization.

### Vectorization Using Intel C++ Compiler

*   While many modern compilers (GCC, Clang, MSVC) support auto-vectorization, the specific options, directives, and reporting mechanisms are often vendor-specific.
*   In this course, we will focus our discussion on the **Intel C++ compiler (`icc`/`icpc` or `icx`)**, which is known for its strong auto-vectorization capabilities and is commonly used in HPC environments like Midway.
*   However, the general principles and common barriers to vectorization apply across different compilers.

### Auto-Vectorization: Example 1 (Vector Addition)

Let's revisit simple vector addition:

```cpp
#include <vector> // Using vectors for simplicity, but raw arrays work too.

int main() {
    const int N = 8; // Small N for illustration
    int a[N] = {1, 2, 3, 4, 5, 6, 7, 8};
    int b[N] = {1, 2, 3, 4, 5, 6, 7, 8};
    int c[N];

    // This loop is a candidate for auto-vectorization
    for (int i = 0; i < N; ++i) {
        c[i] = a[i] + b[i];
    }

    // ... (code to print or use c)
    return 0;
}
```

**Intel Compiler Optimization Levels:**

The Intel compiler uses optimization flags (`-O`) to control the level of optimization, including auto-vectorization:

*   `-O0`: Disable optimizations.
*   `-O1`: Enable basic optimizations, but may disable some that increase code size. Auto-vectorization is typically *off*.
*   `-O2`: **Default level.** Enables most optimizations, including auto-vectorization. Optimizes for speed.
*   `-O3`: Enables more aggressive optimizations (including potentially unsafe loop transformations) that might not always improve performance. Auto-vectorization is *on*.
*   `-Os`: Optimizes for code size, enabling speed optimizations that don't significantly increase size.
*   `-Ofast`: Equivalent to `-O3 -no-prec-div -fp-model fast=2`. Enables aggressive optimizations, potentially sacrificing floating-point precision/compliance for speed.

(Use `icc -help` or `icx -help` to see all available options).

**Compiling Example 1:**

To enable auto-vectorization, we compile with `-O2` (or higher):

```bash
icc -O2 example1.cpp -o example1
# Or, since -O2 is default:
icc example1.cpp -o example1
```

*   **Question:** Is the loop in `example1.cpp` actually auto-vectorized when compiled with `-O2`?

### Vectorization Report

To determine if loops were vectorized and why others were not, we can ask the Intel compiler to generate a report.

*   **Option:** `-qopt-report[=n]` (on Linux/Mac) or `/Qopt-report[:n]` (on Windows).
    *   `n` is the report level (0-5), controlling the amount of detail.
    *   Generates an optimization report file (default: `<target_name>.optrpt`).

*   **Report Levels (`n`):**
    *   `1`: Reports loops successfully vectorized.
    *   `2`: Reports loops not vectorized and provides the main reason.
    *   `3`: Adds information about data dependencies.
    *   `4`: Reports *only* non-vectorized loops.
    *   `5`: Reports *only* non-vectorized loops and adds dependency details (most verbose for failures).

*   **Filtering the Report:** Optimization reports can be very long. To focus only on vectorization information:
    *   `-qopt-report-phase=vec`

**Generating a Report for Example 1:**

Let's request a level 1 report (show vectorized loops) with `-O2`:

```bash
icc -qopt-report=1 -O2 example1.cpp -o example1
```

Now, examine the generated `example1.optrpt` file. You should see output similar to this:

```
LOOP BEGIN at example1.cpp(10,5)
   remark #15300: LOOP WAS VECTORIZED
LOOP END
```

This confirms the loop starting at line 10, column 5, was vectorized.

**What if we disable optimization?**

```bash
icc -qopt-report=1 -O0 example1.cpp -o example1_O0
```

The report `example1_O0.optrpt` will likely *not* show the "LOOP WAS VECTORIZED" remark for that loop, indicating it wasn't vectorized at `-O0`.

### Auto-Vectorization: Example 2 (Matrix Operations)

Consider this code with nested loops performing some matrix operations²:

```cpp
#include <vector>
#define ROWS 100
#define COLS 100

int data[ROWS][COLS]; // Simple 2D array

int main() {
    int sum = 0;

    // Loop 1: Initialize the matrix
    for (int row = 0; row < ROWS; ++row) {
        // Inner Loop 1a
        for (int col = 0; col < COLS; ++col) {
            data[row][col] = row + col;
        }
    }

    // Loop 2: Process the matrix
    for (int row = 0; row < ROWS; ++row) {
        // Inner Loop 2a
        for (int col = 0; col < COLS; ++col) {
            // Potential non-contiguous access: data[col][row]
            sum += data[row][col] + data[col][row];
        }
    }
    // ... (use sum)
    return 0;
}
```

² *Note: The operations here are arbitrary, chosen for illustration.*

**Compile and Generate Report:**

```bash
icc -qopt-report=1 -O2 example2.cpp -o example2
```

**Report Analysis (`example2.optrpt`):**

You might see something like this:

```
LOOP BEGIN at example2.cpp(13,9)  // Inner Loop 1a
   remark #15300: LOOP WAS VECTORIZED
LOOP END

...

LOOP BEGIN at example2.cpp(21,9)  // Inner Loop 2a
   remark #15335: loop was not vectorized: ...
LOOP END
```

This indicates the first inner loop (initialization) was vectorized, but the second inner loop (processing) was not. Why not? The report might give a hint (e.g., related to non-contiguous memory access `data[col][row]`, potential dependencies, or profitability).

### Intel Advisor

*   The Intel toolkit includes various performance analysis tools.
*   **Intel Advisor** is specifically designed to help with vectorization and threading optimization.
*   It provides detailed analysis of loops, identifies barriers to vectorization, suggests potential fixes, and estimates potential performance gains.
*   Let's use Advisor to analyze Example 2.

**Using Intel Advisor on Midway (RCC Cluster):**

1.  **Load Modules:**
    ```bash
    module use /software/intel/oneapi_hpc_2022.1/modulefiles
    module load advisor/2022.0.0
    # You might also need the Intel compiler module loaded
    module load intel/2022.1
    ```

2.  **Get Example Code:** (Assuming `L2Demo.tar` containing `example2.cpp` and a `Makefile` is available)
    ```bash
    # Copy from a shared project directory or your own space
    cp /projects/finm32950/chanaka/L2Demo.tar .
    tar xvf L2Demo.tar
    cd L2Demo/advisor
    ```

3.  **Build (with debug info `-g` and optimization `-O2`):**
    ```bash
    # Ensure Makefile compiles example2.cpp to ./example2 with -g -O2
    make
    ```

4.  **Collect Survey Data:** Advisor runs your application and gathers loop statistics.
    ```bash
    advisor --collect=survey --project-dir=. ./example2
    ```
    This creates a project directory (e.g., `e000`) inside the current directory (`.`).

5.  **Generate Survey Report:** (Often done automatically, but can be explicit)
    ```bash
    advisor --report=survey --project-dir=.
    ```

6.  **Examine Report (GUI):**
    ```bash
    advisor-gui . &
    ```
    *   Navigate the GUI. Use the **Summary Tab** for an overview. Look at "Top Time-Consuming Loops" and "Vectorization Gain/Efficiency".
        *(Image: Intel Advisor Summary Tab showing Program Metrics: Elapsed Time, Vector Instruction Set; Performance Characteristics: CPU Time, Time in Vectorized Loop, Time in Scalar Code; Vectorization Gain/Efficiency; Top Time-Consuming Loops with Self/Total Time and Vector Efficiency)*
    *   Go to the **Survey & Roofline Tab** for details. Select loops to see source code annotation, reasons for non-vectorization, and recommendations.
        *(Image: Intel Advisor Survey & Roofline Tab showing source code with annotations. Highlighting loop at example2.cpp:21 marked as Scalar, with details like "vectorization possible but seems inefficient" or potential dependency issues)*

Advisor provides much richer feedback than the basic compiler report (`-qopt-report`).

---

### Barriers to Vectorization

Compilers cannot vectorize all loops. Common reasons include:

1.  **Non-vectorizable Function Calls:** Calling functions that the compiler doesn't know how to vectorize (e.g., standard `rand()`, I/O functions, complex math functions without SVML versions).
2.  **Data Dependencies:** When the calculation for one iteration of the loop depends on the result of a previous iteration (loop-carried dependency).
3.  **Pointer Aliasing:** When the compiler cannot be sure if different pointers/array references within the loop point to overlapping memory regions. Modifying data through one pointer might affect data read through another, creating a potential dependency.
4.  **Complex Control Flow:** Loops with multiple exit points (`break`, `goto`, `return`), or complex conditional logic inside.
5.  **Non-countable Loops:** Loops where the number of iterations is not known before the loop starts (e.g., `while` loops dependent on runtime data).
6.  **Mixed Data Types:** Sometimes mixing data types within a loop can hinder vectorization.
7.  **Non-contiguous Memory Access:** Accessing data in a pattern that is not sequential in memory (like `data[col][row]` when `data` is row-major) can be inefficient or prevent vectorization.
8.  **Profitability:** Sometimes the compiler *could* vectorize a loop, but estimates the overhead of vectorization (e.g., setting up data, handling loop remainders) outweighs the benefits, especially for loops with very few iterations.

Let's look at examples illustrating some of these barriers.

**Example 3: Non-vectorizable Function Call (`rand`)**

```cpp
#include <cstdlib> // for rand()
#include <vector>

int main() {
    const int N = 8;
    float a[N], b[N], c[N];

    // Loop 1: Contains non-vectorizable rand() call
    for (int i=0; i<N; ++i) {
        a[i] = rand() % 100; // rand() is typically not vectorizable
        b[i] = rand() % 100;
    }

    // Loop 2: Simple addition, likely vectorizable
    for (int i = 0; i < N; ++i) {
        c[i] = a[i] + b[i];
    }
    return 0;
}
```

**Compile and Check Report (Level 5 for details on failure):**

```bash
# Default is -O2
icc -qopt-report=5 -qopt-report-phase=vec example3.cpp -o example3
```

**Report Analysis (`example3.optrpt`):**

```
LOOP BEGIN at example3.cpp(8,5)
   remark #15382: vectorization support: call to function rand() cannot be vectorized   [ example3.cpp(10,18) ]
   ... (details about why it wasn't vectorized)
LOOP END

LOOP BEGIN at example3.cpp(14,5)
   remark #15300: LOOP WAS VECTORIZED
LOOP END
```
The report clearly states that the call to `rand()` prevents vectorization of the first loop. The second loop is vectorized as expected. (Note: The compiler might *unroll* the first loop completely if N is small and known, as seen in an earlier slide's output `#25436: completely unrolled by 8`, which is another optimization but not vectorization).

**Example 4: Data Dependency**

```cpp
// Assume a, b, c are arrays of size N
for (int i = 0; i < N; ++i) {
    // Conditional execution, but the key issue is the dependency
    if(i > 3) {
        // c[i] depends on the previous iteration's c[i-1]
        c[i] = a[i] + b[i] + c[i-1];
    } else {
        // Assuming some base case or different calculation for i <= 3
        // c[i] = a[i] + b[i]; // For simplicity if no else
    }
}
```

**Analysis:**

Let's unroll the loop mentally for `i >= 4`:
*   `i = 4`: `c[4] = a[4] + b[4] + c[3]`
*   `i = 5`: `c[5] = a[5] + b[5] + c[4]`
*   ...

To calculate `c[5]`, we need the value of `c[4]`, which is calculated in the previous iteration. This is a **loop-carried dependency**. We cannot calculate `c[4]`, `c[5]`, `c[6]`, etc., simultaneously in parallel using vector instructions because each depends on the result of the one before it.

**Compiler Report (`-qopt-report=2`):**

```
LOOP BEGIN at example4.cpp(...)
   remark #15344: loop was not vectorized: vector dependence prevents vectorization.
LOOP END
```

**Example 5: Potential Pointer Aliasing**

Consider a function similar to a Black-Scholes pricer component, operating on multiple arrays passed as pointers:

```cpp
void add(float *a, float *b, float *c, float *d, float *e, int N) {
    // Can the compiler be sure a, b, c, d, e don't overlap?
    for (int i=0; i<N; ++i) {
        // If, e.g., 'a' overlaps with 'c', writing to a[i]
        // might affect reading c[i] in the same or later iterations.
        a[i] = b[i] + c[i] + d[i] + e[i];
    }
}
```

**Analysis:**

*   The compiler performs static analysis. It sees multiple pointers (`a`, `b`, `c`, `d`, `e`).
*   It often cannot determine *at compile time* whether these pointers might point to overlapping memory regions (**aliasing**).
*   If aliasing *might* occur, modifying data through one pointer (like `a[i]`) could potentially affect data read through another pointer (like `c[i]`) within the same vectorized "chunk" or across iterations, creating an apparent dependency.
*   To be safe, the compiler might conservatively refuse to vectorize the loop.

**Compiler Report (`-qopt-report=...`): Multiversioning**

In cases of uncertainty like potential aliasing, the compiler might generate **multiple versions** of the loop:

1.  **Version 1 (Optimistic):** A vectorized version, assuming no harmful aliasing occurs.
2.  **Version 2 (Conservative):** A non-vectorized (scalar) or unrolled version.

At runtime, the program performs a check (e.g., comparing pointer addresses) to decide which version to execute.

The optimization report might show entries like this:

```
LOOP BEGIN at example5.cpp(3,5)
<Multiversioned v1>
   remark #25228: Loop multiversioned for Data Dependence /* Could be aliasing */
   remark #15300: LOOP WAS VECTORIZED
LOOP END

LOOP BEGIN at example5.cpp(3,5)
<Multiversioned v2>
   remark #15331: loop was not vectorized: potential computing dependency present. /* or similar */
   /* Or it might be unrolled instead */
   remark #25436: completely unrolled by 8
LOOP END
```

While multiversioning allows potential vectorization, it adds runtime overhead for the check and increases code size. It's often better to explicitly tell the compiler about aliasing if we know it's safe.

**Example 6: Multiple Loop Exits**

Vectorization generally requires loops that run for a predetermined number of iterations (or predictable chunks). Early exits complicate this.

```cpp
// Assume a, b are arrays of size N
int i = 0;
while (i < N) {
    a[i] = a[i] * b[i];

    // Conditional exit based on runtime value
    if (a[i] < 2) {
        break; // Multiple exit points prevent vectorization
    }
    ++i;
}
```

**Analysis:**

*   The loop has a conditional `break` statement.
*   The compiler cannot easily vectorize this because it doesn't know how many iterations will execute in a vector chunk before potentially needing to exit.
*   Auto-vectorization typically requires loops with a single entry point and a single exit point (completing all iterations).

**Compiler Report (`-qopt-report=2`):**

```
LOOP BEGIN at example6.cpp(...)
   remark #15520: loop was not vectorized: loop with multiple exits cannot be vectorized
LOOP END
```

### Reading Vectorization Reports Summary

*   The examples above demonstrate common reasons why loops might not be vectorized.
*   Use `-qopt-report=1` to check if expected loops *were* vectorized.
*   Use `-qopt-report=2` (or `5` for more detail) and `-qopt-report-phase=vec` to find out *why* specific loops were *not* vectorized.
*   Understanding these reports is the first step towards improving vectorization.

---

### Improving Vectorization

When auto-vectorization doesn't occur or isn't optimal, we can employ several techniques:

1.  **Use Vectorized Libraries (e.g., SVML):** Replace non-vectorizable function calls with their vectorized equivalents.
2.  **Compiler Directives:** Provide hints or commands to the compiler using pragmas or keywords.
3.  **Rewrite Code:** Modify the code structure to be more vectorization-friendly.

#### 1. Using Vectorized Implementations - Short Vector Math Library (SVML)

*   **Problem:** Loops containing calls to standard math functions (like `sin`, `cos`, `exp`, `log`, `pow`, `sqrt`) are often not auto-vectorized because the standard library versions operate on scalars.
*   **Solution:** Intel compilers provide the **Short Vector Math Library (SVML)**, which contains vectorized implementations of many common math functions.
*   When the compiler encounters a standard math function call inside a loop during optimization (e.g., at `-O2`), it can automatically replace it with a call to the corresponding, faster SVML version if available. This often enables the loop to be vectorized.

**Example:**

```cpp
#include <cmath> // For sinf

void test(float* a, float* b, int n) {
    // Loop containing a standard math function
    for (int i=0; i<n; ++i) {
        a[i] = sinf(b[i]); // Call to scalar sinf
    }
}
```

When compiled with `icc -O2`, the compiler may replace `sinf` with an internal, vectorized SVML call, allowing the loop to be vectorized (check the `-qopt-report`).

**SVML Support:** Includes vectorized versions for functions like:
`sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `log`, `log2`, `log10`, `exp`, `exp2`, `sinh`, `cosh`, `tanh`, `asinh`, `acosh`, `atanh`, `erf`, `erfc`, `erfinv`, `sqrt`, `cbrt`, `trunc`, `round`, `ceil`, `floor`, `fabs`, `fmin`, `fmax`, `pow`, `atan2`, and more.

*   *Reference: [Intel C++ Compiler Developer Guide - Intrinsics for SVML](https://www.intel.com/content/www/us/en/docs/cpp-compiler/developer-guide-reference/2021-8/intrinsics-for-short-vector-math-library-ops.html)* (Note: Direct SVML intrinsic calls are possible but usually unnecessary as the compiler handles replacement automatically).

#### 2. Compiler Directives (Pragmas)

*   **Problem:** The compiler uses static analysis and must guarantee correctness. It might refuse to vectorize due to ambiguity (like potential pointer aliasing) or if it deems vectorization potentially unsafe or unprofitable, even if the programmer knows it's safe and beneficial.
*   **Solution:** Use **compiler directives** (in C/C++, often `#pragma ...`) to provide guidance or override the compiler's default behavior for a specific code block (usually a loop).

**Intel C++ Compiler Pragmas for Vectorization:**

*   `#pragma simd`: **Enforces** vectorization. Use this when you are certain the loop is safe to vectorize (e.g., no loop-carried dependencies). The compiler will vectorize if possible; it might issue an error or warning if dependencies prevent it.
*   `#pragma ivdep`: **Ignores Vector Dependencies.** Tells the compiler to ignore potential vector dependencies (like those arising from possible pointer aliasing). Use this carefully when you *know* that no harmful dependencies exist (e.g., pointers definitely don't overlap).
*   `#pragma vector always`: Forces vectorization even if the compiler thinks it might not be efficient/profitable. Use with caution; can sometimes lead to slower code if the compiler's heuristics were correct.
*   `#pragma novector`: Explicitly tells the compiler *not* to vectorize a specific loop.
*   `#pragma unroll[(n)]`: Tells the compiler to unroll the loop (optionally by a factor `n`).
*   `#pragma nounroll`: Tells the compiler *not* to unroll a specific loop.

*   *Reference: [Intel C++ Compiler Developer Guide - Pragmas](https://www.intel.com/content/www/us/en/docs/cpp-compiler/developer-guide-reference/2021-8/pragmas.html)*
*   *Note:* We will discuss OpenMP directives next week, which offer another powerful way to control parallelism, including SIMD loops.

**Example: Using Pragmas**

*   **For Example 5 (Pointer Aliasing):** If we know pointers `a, b, c, d, e` do not overlap, we can force vectorization:
    ```cpp
    void add(float *a, float *b, float *c, float *d, float *e, int N) {
        #pragma ivdep // Assume no dependencies due to aliasing
        // OR #pragma simd // Assert vectorization is safe
        for (int i=0; i<N; ++i) {
            a[i] = b[i] + c[i] + d[i] + e[i];
        }
    }
    ```
*   **For Example 2 (Second Inner Loop):** If Advisor/report said "vectorization possible but seems inefficient", we could force it:
    ```cpp
        // Inside Loop 2
        #pragma vector always
        for (int col = 0; col < COLS; ++col) {
            sum += data[row][col] + data[col][row];
        }
    ```

#### 3. Writing Code to Support Vectorization

Sometimes, restructuring the code itself can enable or improve auto-vectorization:

1.  **Simplify Loops:** Avoid complex termination conditions and multiple exit points (`break`, `return`, `goto`).
2.  **Eliminate Data Dependencies:**
    *   If a dependency only involves the first or last few iterations, consider **loop peeling**: handle those iterations separately outside the main loop, making the main loop dependency-free.
        *   **Before (Dependency on `a[0]`):**
            ```cpp
            for (int i=0; i<10; ++i) {
                a[i] = b[i] + a[0]; // Read of a[0] creates dependency if N > vector width
            }
            ```
        *   **After (Loop Peeling - maybe not needed here, but illustrates):**
            *If `a[0]` itself was written inside, peeling might help. A better example is the `c[i]=...+c[i-1]` case:*
            **Before:** `for(i=1..){ c[i]=...+c[i-1]; }`
            **After:** `c[0]=...; for(i=1..){ c[i]=...+c[i-1]; }` -> *This doesn't remove the dependency.* Loop peeling is more useful for removing dependencies related to boundary conditions, not inherent sequential dependencies. Re-thinking this point: The slide example `a[i]=b[i]+a[0]` doesn't have a loop-carried dependency *on `a[i]`*, but reading `a[0]` repeatedly might be handled differently by the vectorizer. The *real* use for peeling is often combined with alignment or handling loop remainders. The `c[i]=...+c[i-1]` example fundamentally cannot be vectorized easily.
    *   Use temporary scalar variables or restructure calculations if possible.
3.  **Avoid Mixing Data Types:** Keep operations within a loop focused on compatible data types if possible.
4.  **Ensure Contiguous Memory Access:** Access array elements sequentially (e.g., iterate through the innermost dimension of a multi-dimensional array stored in row-major order).
5.  **Use Aligned Data:** Performance can sometimes be improved if data starts on memory addresses that are multiples of the vector register size (e.g., 16, 32, or 64 bytes). Alignment directives (`__attribute__((aligned(...)))` or `__declspec(align(...))`) can help.
6.  **Help the Compiler with Trip Counts:** Ensure the loop iteration count is known or easily calculable at the loop entry if possible.

### Unrolling Loops

*   **Context:** We cannot vectorize every loop (due to dependencies, etc.). When vectorization isn't possible, **loop unrolling** can still offer performance benefits.
*   **Problem:** Loops incur overhead in each iteration: checking the termination condition and updating the loop counter.
*   **Solution:** Unrolling reduces this overhead by performing the work of multiple original iterations within a single iteration of the unrolled loop.

**Example:**

*   **Original Loop:**
    ```cpp
    for (int i=0; i<4; ++i) {
        a[i] = b[i] + c[i];
    }
    ```
*   **Fully Unrolled:** (Compiler might do this if N is small and known)
    ```cpp
    a[0] = b[0] + c[0];
    a[1] = b[1] + c[1];
    a[2] = b[2] + c[2];
    a[3] = b[3] + c[3];
    ```
*   **Unrolled by Factor of 2:**
    ```cpp
    // Assumes N is a multiple of 2, or needs remainder handling
    for (int i=0; i<4; i+=2) {
        a[i]   = b[i]   + c[i];
        a[i+1] = b[i+1] + c[i+1];
    }
    ```
*   **Note:** Unrolled code is still executed sequentially (instruction by instruction), unlike vectorization which executes multiple data operations in parallel within one instruction. It improves performance by reducing loop overhead and potentially enabling better instruction scheduling.
*   Performance gains depend on the unrolling factor, and the optimal factor often requires measurement (profiling).
*   Compilers often perform unrolling automatically at `-O2` or higher, or it can be guided using `#pragma unroll`.

### Vectorization: Usage in Libraries

Vectorization is a key optimization technique used in many popular numerical libraries:

1.  **Eigen:** A C++ template library for linear algebra. ([http://eigen.tuxfamily.org/index.php?title=Main_Page](http://eigen.tuxfamily.org/index.php?title=Main_Page))
2.  **RapidJSON:** A fast JSON parser/generator for C++. ([https://github.com/Tencent/rapidjson](https://github.com/Tencent/rapidjson)) (Uses SIMD for parsing speed).
3.  **NumPy:** The fundamental package for scientific computing in Python. Its core operations on arrays are often implemented in C/Fortran and heavily leverage vectorization. ([https://www.pythonlikeyoumeanit.com/Module3_IntroducingNumpy/VectorizedOperations.html](https://www.pythonlikeyoumeanit.com/Module3_IntroducingNumpy/VectorizedOperations.html))

### Vectorization: Remarks

*   Vectorization (using SIMD instructions) is a crucial performance optimization technique on modern CPUs.
*   We discussed two ways to achieve it: low-level intrinsics and compiler auto-vectorization.
*   Auto-vectorization is preferred for maintainability and portability but isn't guaranteed.
*   Every application and loop is different; there are no hard-and-fast rules that guarantee success.
*   Understanding barriers (dependencies, function calls, aliasing, etc.) and using tools (compiler reports, Intel Advisor) and techniques (SVML, pragmas, code restructuring) significantly increases the chances of achieving good performance through vectorization.

---

## Using Multicore Nodes

### Motivation: Beyond Single-Core Performance

Let's revisit the VTune Profiler report from a previous session. The "Effective CPU Utilization Histogram" often shows that even on a machine with many CPU cores (e.g., >90 on a Midway node), a standard sequential program might only use one core.

*(Image: Intel VTune Profiler Effective CPU Utilization Histogram showing 100% utilization for 1 core and 0% for >1 cores, indicating a single-threaded application on a multicore system).*

*   We have many cores available, but our program uses only one.
*   **Question:** How can we utilize more than one CPU core to make our programs run faster?

### Parallel Programming - Introduction

*   An obvious way to get work done faster is to perform multiple tasks **simultaneously** or **in parallel**.
*   This concept isn't new, but it has become critically important in modern computing.
*   We've already seen one form of parallelism: **vectorization (SIMD)**, which achieves parallelism *within* a single CPU core at the *instruction level*.
*   Our next topic is achieving parallelism by using **multiple CPU cores**, typically through **multithreading**.

### Why Multicore? Moore's Law and Hardware Trends

*   **Moore's Law:** Historically stated that computing power (often interpreted as transistor count or performance) doubles approximately every two years.
*   **Observation:** Graphs of microprocessor trends show this held true for single-thread performance and clock frequency until roughly the mid-2000s / 2010.
    *(Image: 50 Years of Technology Scaling graph showing Transistor count continuing exponential growth, while Frequency and Single-Thread Performance plateaued around 2005-2010. Typical Power also stabilized or increased slightly, while Number of Logical Cores started increasing significantly around that time.)*
*   **Frequency Limit:** Increasing CPU clock frequency further hit physical limitations (power consumption, heat generation due to leakage currents in smaller transistors). "The free lunch is over."
*   **Single-Thread Performance:** While clock speeds stalled, single-thread performance continued to improve for a while, largely due to architectural enhancements like better branch prediction, deeper pipelines, and crucially, **vectorization (SIMD)**. However, this improvement also slowed down.
*   **The Trend:** To continue increasing overall computing power, the industry shifted towards putting **more CPU cores** onto a single chip.
*   **Benefits of Multicore:**
    *   Achieve higher total performance than by increasing single-core speed alone.
    *   Often with better power efficiency (less power consumption and heat generation) compared to pushing a single core to extreme frequencies.

### Learning Parallel Programming

*   **The Challenge:** The shift to multicore processors presents a new challenge for programmers.
*   **Necessity:** To take advantage of modern hardware, we *must* learn how to write parallel programs that can utilize multiple cores.
*   **Consequence:** Writing purely sequential code means wasting a significant amount of available computing power.
*   **Ubiquity:** Parallel computing is no longer an exotic, specialized topic. It's a fundamental skill required for almost any performance-sensitive programming.

### Parallel Computing Examples (Conceptual)

Many computational tasks exhibit **natural parallelism**, where different parts of the calculation can be done independently.

*   **Example 1: Vector Addition**
    ```
    [ a0 ]   [ b0 ]   [ c0 = a0+b0 ]
    [ a1 ] + [ b1 ] = [ c1 = a1+b1 ]
    [ a2 ]   [ b2 ]   [ c2 = a2+b2 ]
    ```
    Each element `c[i]` can be computed independently of the others. `c[0]` doesn't depend on `c[1]`. We can compute `c[0]`, `c[1]`, `c[2]`, etc., all at the same time if we have enough processing units.

*   **Example 2: Matrix Multiplication**
    `C = A * B`, where `C[i,j] = sum(A[i,k] * B[k,j])` for `k = 0 to K-1`.
    *(Mathematical formula and matrix representation shown)*
    The calculation of each element `C[i,j]` in the resulting matrix `C` is independent of the calculation of any other element `C[p,q]`. All elements of `C` can, in principle, be computed in parallel.

### Identifying and Exploiting Natural Parallelism

*   **Goal:** Our goal in HPC is to identify this natural parallelism in applications and exploit it to speed up execution.
*   **Technologies Explored:**
    1.  **Vectorization (SIMD):** Parallelism within a core (already covered). ✓
    2.  **Multicore Programming (Multithreading):** Parallelism across cores on a single node (this section).
    3.  **GPGPU (General-Purpose GPU computing):** Massively parallel computing using graphics cards (covered later).
    *   *(FPGA is another relevant technology, but outside the scope of this course).*

---

### Multithreading

*   **Concept:** To use multiple CPU cores, we break down a program's work into smaller **tasks**.
*   We then use **threads** to execute these tasks, potentially assigning different threads to different cores, allowing them to run in parallel.
*   This practice is known as **multithreading**.
*   We will explore how to use threads in C++ to perform work in parallel.

#### Threads

*   A **thread** is the smallest sequence of programmed instructions that can be managed independently by an operating system scheduler.
*   A single process (running program) can contain multiple threads.
*   Threads within the same process share the same memory space (code, heap data, global variables), which makes communication easy but also introduces potential problems (like race conditions).
*   Each thread has its own execution stack and register set.

#### Using Threads: Example 1 (Hello World)

Let's modify the classic "Hello, World!" example to perform the printing task in a separate thread using the C++ standard library `<thread>`.

```cpp
#include <iostream>
#include <thread> // Required for std::thread

// Function to be executed by the new thread
void Greeting() {
    std::cout << "Hello, World from thread!" << std::endl;
}

int main() {
    // 1. Create a new thread 't' that starts executing the Greeting function.
    std::thread t(Greeting);

    std::cout << "Hello from main thread!" << std::endl;

    // 2. Wait for thread 't' to finish its execution before main exits.
    t.join(); // Without join(), main might exit before 't' prints.

    return 0;
}
```

**Building on Midway (requires linking the pthreads library):**

```bash
icc helloworld.cpp -o helloworld -lpthread
# or using C++11 standard flag which might implicitly link
# icx -std=c++11 helloworld.cpp -o helloworld
```

**Analysis:**

*   **Creating a Thread:** We use `std::thread t(FunctionName, args...);`. The constructor takes a callable entity (function pointer, lambda, function object) as the entry point for the new thread, followed by any arguments to pass to it.
*   **Multiple Threads:** Once `std::thread t(...)` is called, our program has *two* threads running concurrently:
    1.  The original **main thread**.
    2.  The newly created **thread `t`**.
*   **`join()`:** The `t.join()` call makes the calling thread (the main thread in this case) **wait** until thread `t` completes its execution. This is essential for ensuring `t` finishes its work and for proper cleanup.
*   **`<thread>` Header:** Provides the `std::thread` class and related functions.
*   *Reference: [cppreference - std::thread](http://www.cplusplus.com/reference/thread/thread/)*

#### Thread `join()` and `detach()`

Once a `std::thread` object is created, it represents an active thread of execution. Before the `std::thread` object is destroyed, you *must* decide what to do with the associated thread:

1.  **`join()`:** Wait for the thread to complete. This allows the joining thread to safely access results or ensures the thread's work is done. A thread can only be joined once.
2.  **`detach()`:** Separate the thread of execution from the `std::thread` object. The thread continues to run independently in the background ("daemon" thread). The original `std::thread` object no longer represents the running thread. You can no longer `join` it. Detached threads must manage their own lifetime and resources carefully, as the main program won't automatically wait for them.

*   **Rule:** Every `std::thread` must be either `join()`ed or `detach()`ed before its destructor is called (e.g., when it goes out of scope) to avoid `std::terminate` being called.

#### How Many Threads?

*   A program can technically create a large number of threads (hundreds or thousands).
*   However, the number of threads that can truly run **in parallel** is limited by the number of available CPU cores.
*   If you create more threads than cores, the Operating System (OS) uses a **scheduling algorithm** to switch between threads, giving each thread a slice of CPU time on the available cores (concurrency via time-slicing).
*   Creating too many threads can lead to significant overhead from context switching and scheduling, potentially slowing down the program instead of speeding it up.

---

#### Detour: Lambdas (C++)

*   We saw that `std::thread` takes a function pointer (like `Greeting`) as its entry point.
*   Other ways to provide the initial task for a thread include:
    *   Using a **lambda expression**.
    *   Using a **function object** (an object of a class that overloads `operator()`).
*   Lambdas are often very convenient for defining short, inline functions, especially for threads or algorithms.

**Lambda Syntax:**

A lambda expression has the following general form:

```cpp
[capture_clause](parameters) -> return_type {
    // Function body
}
```

*   **`[capture_clause]`:** (Required) Specifies which variables from the surrounding scope are accessible inside the lambda and how (by value or by reference).
    *   `[]`: Capture nothing.
    *   `[=]`: Capture all used automatic variables by value.
    *   `[&]`: Capture all used automatic variables by reference.
    *   `[x, &y]`: Capture `x` by value, `y` by reference.
    *   `[=, &z]`: Capture all by value, except `z` by reference.
    *   `[&, w]`: Capture all by reference, except `w` by value.
*   **`(parameters)`:** (Optional) List of parameters the lambda takes, just like a regular function.
*   **`-> return_type`:** (Optional) Explicitly specifies the return type. Often deduced by the compiler.
*   **`{ function body }`:** (Required) The code the lambda executes.

**Example Simple Lambda:**

```cpp
// Lambda that takes a string and prints it
[] (std::string s) {
    std::cout << s << std::endl;
}
```

**Creating a Thread with a Lambda:**

```cpp
#include <iostream>
#include <thread>
#include <string>

int main() {
    std::string msg = "Hello from Lambda Thread!";

    // Create a thread using a lambda
    // Capture 'msg' by value ([=]) so the lambda has its own copy
    std::thread t([=]() {
        std::cout << msg << std::endl;
    });

    t.join();
    return 0;
}
```

**Lambda Captures:**

*   **Capture by Value (`=`):** The lambda gets a *copy* of the variable at the time the lambda is *created*. Changes to the original variable later don't affect the lambda's copy (and the lambda cannot modify the original through its copy unless the variable is mutable). Reads are allowed, writes to the copy inside the lambda are allowed if `mutable` keyword is used, but don't affect original.
*   **Capture by Reference (`&`):** The lambda holds a *reference* to the original variable. Changes to the original variable *are* visible inside the lambda, and the lambda *can* modify the original variable. Allows read and write access to the original. **Caution:** Ensure the referenced variable lives at least as long as the lambda execution!

---

#### Using Threads: Example 2 (Matrix Multiplication Parallelization)

Let's parallelize the matrix multiplication `C = A * B`.

**Serial Program Recap:**

```cpp
// Assuming matrix is a class or struct, e.g., typedef std::vector<std::vector<double>> matrix;
void matrix_multiply_serial(const matrix& m1, const matrix& m2,
                           matrix& m3, int rows, int columns) {
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < columns; ++j) {
            m3[i][j] = 0; // Assuming m3 is pre-sized
            for (int k = 0; k < rows; ++k) { // Assuming square matrices or correct inner dim
                m3[i][j] += m1[i][k] * m2[k][j];
            }
        }
    }
}
```
*   Inputs `m1`, `m2` passed by `const` reference.
*   Output `m3` passed by reference.

**Parallelization Strategies:**

This is naturally parallel. We can divide the work in several ways:

1.  **One thread per element:** Create `rows * columns` threads. Each thread calculates a single `m3[i][j]`.
2.  **One thread per row:** Create `rows` threads. Each thread calculates all elements in a single row `m3[i][...]`.
3.  **One thread per column:** Create `columns` threads. Each thread calculates all elements in a single column `m3[...][j]`. (May be less cache-friendly for row-major storage).

Which is better? Usually, creating a number of threads closer to the number of CPU cores is more efficient than creating thousands or millions of threads. Strategy 2 (one thread per row) is often a good starting point if `rows` is reasonably large.

**Implementation: One Thread Per Element (Potentially Inefficient & Buggy)**

```cpp
#include <vector>
#include <thread>
// Assume matrix type defined

void multiply_matrix_per_element(const matrix& m1, const matrix& m2,
                                matrix& m3, int rows, int columns) {
    std::vector<std::thread> threads;
    threads.reserve(rows * columns); // Pre-allocate space

    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < columns; ++j) {
            // Create a thread for element (i, j)
            // BUGGY CAPTURE: [=] captures i and j by value *at the time of lambda creation*.
            // By the time the thread runs, i and j in the outer loops might have changed!
            threads.emplace_back([=, &m1, &m2, &m3]() { // Captures needed refs explicitly
                double sum = 0;
                for (int k = 0; k < columns; ++k) { // Assuming inner dimension is columns of m1
                    sum += m1[i][k] * m2[k][j];
                }
                m3[i][j] = sum; // Race condition if matrix elements aren't distinct? No, different elements.
            });
        }
    }

    // Wait for all threads to complete
    for (auto& t : threads) {
        t.join();
    }
    // This approach creates potentially too many threads and has a capture bug.
}
```
*   **Critical Bug:** The lambda capture `[=]` captures `i` and `j` by value. However, the loops continue, and `i` and `j` change. When the thread actually executes the lambda body, it uses the copied values of `i` and `j` from when the lambda was *created*, not the values intended for that specific element calculation. All threads might end up calculating the same element or accessing invalid indices. You need to pass `i` and `j` explicitly or capture them correctly (e.g., copy them inside the loop before the lambda).

**Implementation: One Thread Per Row (Better Approach)**

```cpp
#include <vector>
#include <thread>
// Assume matrix type defined

void multiply_matrix_per_row(const matrix& m1, const matrix& m2,
                            matrix& m3, int rows, int columns) {
    std::vector<std::thread> threads;
    threads.reserve(rows);

    for (int i = 0; i < rows; ++i) {
        // Create a thread for row 'i'
        // Capture 'i' by value - this is correct, each thread gets its own row index.
        threads.emplace_back([=, &m1, &m2, &m3, columns]() { // Need columns too
            for (int j = 0; j < columns; ++j) {
                double sum = 0;
                for (int k = 0; k < m1[0].size(); ++k) { // Use actual inner dimension
                    sum += m1[i][k] * m2[k][j];
                }
                m3[i][j] = sum; // Safe: Each thread writes to a different row
            }
        });
    }

    // Wait for all threads
    for (auto& t : threads) {
        t.join();
    }
}
```
*   This version correctly captures the row index `i` by value for each thread. It creates fewer threads than the per-element approach, likely leading to better performance due to less overhead.

**Performance Comparison:**

We now have three implementations:
1.  Sequential (single thread)
2.  Parallel: One thread per element (buggy, likely very slow due to overhead)
3.  Parallel: One thread per row (likely faster than sequential)

Let's run these and measure time (results depend heavily on system, matrix size, compiler, etc.).

**Example Results (Laptop):**

```
(Serial) Time elapsed 1398 ms
(Thread per element) Time elapsed 70039 ms  <-- Very slow due to overhead and likely capture bug impact
(Thread per row) Time elapsed 571 ms       <-- Fastest, showing benefit of parallelization
```

**Observations:**

*   Threads *can* allow us to gain performance by using multiple cores.
*   However, **more threads do not necessarily mean better performance**. Creating too many threads (like the per-element approach) introduces significant **overhead** (thread creation, scheduling, context switching) that can overwhelm the benefits of parallelism.
*   When using threads, we must pay attention to the **overhead** involved and choose a parallelization strategy that balances the amount of work per thread with the number of threads created. Generally, aim for a number of threads roughly equal to the number of available cores, ensuring each thread has a substantial amount of work to do.

---

### Sharing Data and Race Conditions

*   **Shared Data:** Threads within the same process share the same memory space. This means they can all access the same global variables, heap-allocated data, etc.
*   **Reading:** Multiple threads can safely *read* the same data concurrently (e.g., reading from `m1` and `m2` in the matrix multiplication).
*   **Writing:** Problems arise when multiple threads try to *write* to the same shared data concurrently, or when one thread writes while another reads the same data.

**Example 3: The Counter Problem (Race Condition)**

Consider this code where multiple threads increment a shared counter:

```cpp
#include <iostream>
#include <vector>
#include <thread>

unsigned long counter = 0; // Shared counter
const int numThreads = 10;
const int increments_per_thread = 100000;

int main() {
    std::vector<std::thread> threads;

    for (int j = 0; j < numThreads; ++j) {
        // Each thread increments the *shared* counter
        threads.emplace_back([]() {
            for (int i = 0; i < increments_per_thread; ++i) {
                counter++; // Potential RACE CONDITION
            }
        });
    }

    for (auto& t : threads) {
        t.join();
    }

    // Expected value: numThreads * increments_per_thread = 1,000,000
    std::cout << "Final counter value: " << counter << std::endl;

    return 0;
}
```

**Building and Running on Midway:**

1.  **Get a compute node:**
    ```bash
    sinteractive --time=0:30:0 --ntasks=8 --account=finm32950
    ```
2.  **Build:**
    ```bash
    icc counter.cpp -o counter -lpthread
    ```
3.  **Run:**
    ```bash
    ./counter
    ```

**What's the value of `counter`?**

You will likely find that the final value is *less than* the expected 1,000,000, and the value might even change slightly between runs. Why?

**Race Condition Explained:**

The operation `counter++` is not **atomic**. It typically involves three steps at the machine level:
1.  **Read:** Read the current value of `counter` from memory into a CPU register.
2.  **Increment:** Increment the value in the register.
3.  **Write:** Write the new value from the register back to memory.

Because threads run concurrently, these steps can interleave in harmful ways:

*   **Scenario 1 (Lost Update):**
    *   Thread t1 reads `counter` (value 0).
    *   Thread t2 reads `counter` (value 0).
    *   Thread t1 increments its register (to 1).
    *   Thread t2 increments its register (to 1).
    *   Thread t1 writes 1 back to `counter`.
    *   Thread t2 writes 1 back to `counter`.
    *   **Result:** `counter` is 1, but it should be 2. An increment was lost.

*   **Scenario 2 (Correct Update):**
    *   Thread t1 reads `counter` (value 0).
    *   Thread t1 increments its register (to 1).
    *   Thread t1 writes 1 back to `counter`.
    *   Thread t2 reads `counter` (value 1).
    *   Thread t2 increments its register (to 2).
    *   Thread t2 writes 2 back to `counter`.
    *   **Result:** `counter` is 2, which is correct.

Since the exact interleaving depends on OS scheduling and timing, the final result is unpredictable and usually incorrect. This situation, where the outcome depends on the unpredictable timing of concurrent threads accessing shared resources, is called a **race condition**.

#### Critical Regions and Mutual Exclusion

*   The part of the code where shared resources are accessed (like `counter++`) is known as the **critical section** or **critical region**.
*   To avoid race conditions, we need to ensure that only one thread can execute the code within the critical section at any given time. This principle is called **mutual exclusion**.

#### Using Locks (Mutexes)

One common way to achieve mutual exclusion is by using a **lock**. The most basic type of lock is a **mutex** (short for MUTual EXclusion).

*   **Concept:** A mutex is like a token. Only one thread can "hold" the mutex at a time.
*   **Mechanism:**
    1.  Before entering the critical section, a thread tries to `lock()` the mutex.
    2.  If the mutex is available, the thread acquires the lock and proceeds into the critical section.
    3.  If the mutex is already held by another thread, the current thread **blocks** (waits) until the mutex becomes available.
    4.  After leaving the critical section, the thread must `unlock()` the mutex, allowing another waiting thread to acquire it.

**C++ Mutex (`<mutex>` header):**

```cpp
#include <iostream>
#include <vector>
#include <thread>
#include <mutex> // Required for std::mutex

unsigned long counter = 0;
std::mutex count_mutex; // Mutex to protect the counter

// ... (numThreads, increments_per_thread)

int main() {
    std::vector<std::thread> threads;
    for (int j = 0; j < numThreads; ++j) {
        threads.emplace_back([]() {
            for (int i = 0; i < increments_per_thread; ++i) {
                count_mutex.lock();   // Acquire the lock
                // --- Critical Section Start ---
                counter++;
                // --- Critical Section End ---
                count_mutex.unlock(); // Release the lock
            }
        });
    }
    // ... (join threads and print counter)
    // Now the final counter value should be correct (1,000,000)
    return 0;
}
```

By guarding the critical section (`counter++`) with `lock()` and `unlock()`, we ensure only one thread modifies the counter at a time, avoiding the race condition.

#### Deadlocks

Using locks introduces a new potential problem: **deadlock**.

*   **Problem:** What if a thread locks a mutex but never unlocks it? (e.g., due to forgetting `unlock()`, or an exception occurring between `lock()` and `unlock()`).
*   **Result:** No other thread will ever be able to acquire that mutex. Any thread waiting for the mutex will wait forever. The program grinds to a halt.
*   **Example (Exception):**
    ```cpp
    mutex.lock();
    // critical_region_code; // This code might throw an exception!
    mutex.unlock(); // If exception occurs, this line is never reached!
    ```

#### `std::lock_guard` (RAII for Mutexes)

To prevent deadlocks caused by forgetting to unlock or by exceptions, C++ provides helper classes that use the **RAII** (Resource Acquisition Is Initialization) technique. `std::lock_guard` is the simplest.

*   **Concept:** `std::lock_guard` is an object that locks a given mutex when the `lock_guard` object is *created* (in its constructor) and automatically unlocks the mutex when the `lock_guard` object is *destroyed* (in its destructor, e.g., when it goes out of scope).
*   **Benefit:** Ensures the mutex is always unlocked, even if exceptions occur.

**Using `std::lock_guard`:**

```cpp
#include <mutex>
#include <thread>
#include <vector>
// ... (counter, count_mutex, etc.)

int main() {
    std::vector<std::thread> threads;
    for (int j = 0; j < numThreads; ++j) {
        threads.emplace_back([]() {
            for (int i = 0; i < increments_per_thread; ++i) {
                // Create lock_guard: locks count_mutex upon creation
                std::lock_guard<std::mutex> guard(count_mutex);

                // --- Critical Section Start ---
                counter++;
                // --- Critical Section End ---

            } // 'guard' goes out of scope here, destructor unlocks count_mutex
              // This happens even if counter++ somehow threw an exception.
        });
    }
    // ... (join threads and print counter)
    return 0;
}
```
Using `std::lock_guard` is the preferred way to manage simple mutex locking in modern C++.

---

### Atomics

Another way to handle concurrent access to simple data types like counters without using explicit locks is via **atomic operations**.

*   **Concept:** Atomic operations are guaranteed by the hardware and system libraries to execute as a single, indivisible unit. From the perspective of other threads, an atomic operation appears to happen instantaneously (all at once or not at all).
*   **Benefit:** They avoid race conditions for simple operations (like incrementing, adding, exchanging) without the need for mutexes, thus avoiding potential deadlocks and the overhead of locking.
*   **Limitation:** The range of available atomic operations is limited. For complex operations involving multiple shared variables that must be updated consistently, mutexes are still necessary.
*   **C++ Atomics (`<atomic>` header):** C++ provides atomic types via the `std::atomic<T>` template.

**Using `std::atomic` for the Counter:**

```cpp
#include <iostream>
#include <vector>
#include <thread>
#include <atomic> // Required for std::atomic

std::atomic<unsigned long> counter = 0; // Atomic counter

// ... (numThreads, increments_per_thread)

int main() {
    std::vector<std::thread> threads;
    for (int j = 0; j < numThreads; ++j) {
        threads.emplace_back([]() {
            for (int i = 0; i < increments_per_thread; ++i) {
                counter++; // This increment is now atomic and thread-safe
            }
        });
    }
    // ... (join threads and print counter)
    // Final counter value should be correct (1,000,000)
    return 0;
}
```
The `counter++` operation on a `std::atomic` variable is handled atomically by the system, ensuring correctness without explicit locking. For simple counters or flags shared between threads, atomics are often more efficient than mutexes.

*   *Reference: [cppreference - std::atomic](http://en.cppreference.com/w/cpp/header/atomic)*

---

**End of Lecture 2**