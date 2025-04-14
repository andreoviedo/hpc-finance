import numpy as np
import time

# Defining the main function for the julia set.
# As we are using numpy this should be faster than the pure python example (but maybe not as fast as the Cython example? Idk)

def julia_set(c, width=800, height=800, x_min=-2, x_max=2, y_min=-2, y_max=2, max_iter=100):
    # Create a grid of complex numbers
    x = np.linspace(x_min, x_max, width, endpoint=False) # So .. it seems the endpoint is not included in the class example
    y = np.linspace(y_min, y_max, height, endpoint=False)
    X, Y = np.meshgrid(x, y)
    Z = X + 1j * Y
    
    # Initialize the output array
    output = np.zeros(Z.shape, dtype=int)
    
    # Iterate the Julia set formula
    for i in range(max_iter):
        mask = np.abs(Z) <= 2
        Z[mask] = Z[mask]**2 + c
        output += mask
    
    print(f"Total sum of the output array: {np.sum(output)}")
    return output

def main():
    # Complex constant matching the pure Python example
    c = complex(-0.62772, -0.42193)

    # Generate the Julia set with parameters matching the pure Python example in class
    start_time = time.time()
    julia = julia_set(c, width=1000, height=1000, x_min=-1.8, x_max=1.8, y_min=-1.8, y_max=1.8, max_iter=300)
    end_time = time.time()
    secs = end_time - start_time
    print(f"NumPy Julia set generation took {secs:.4f} seconds")

    # Print basic statistics
    print(f"Julia set generated with c = {c.real:.5f} + {c.imag:.5f}i")
    print(f"Shape: {julia.shape}")
    print(f"Max iterations: {julia.max()}")
    print(f"Min iterations: {julia.min()}")

if __name__ == "__main__":
    main() 