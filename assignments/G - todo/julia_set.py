import numpy as np

def julia_set(c, width=800, height=800, x_min=-2, x_max=2, y_min=-2, y_max=2, max_iter=100):
    # Create a grid of complex numbers
    x = np.linspace(x_min, x_max, width)
    y = np.linspace(y_min, y_max, height)
    X, Y = np.meshgrid(x, y)
    Z = X + 1j * Y
    
    # Initialize the output array
    output = np.zeros(Z.shape, dtype=int)
    
    # Iterate the Julia set formula
    for i in range(max_iter):
        mask = np.abs(Z) <= 2
        Z[mask] = Z[mask]**2 + c
        output += mask
    
    return output

def main():
    # Example complex constant for Julia set
    c = -0.7 + 0.27j
    
    # Generate the Julia set
    julia = julia_set(c)
    
    # Print basic statistics
    print(f"Julia set generated with c = {c.real:.2f} + {c.imag:.2f}i")
    print(f"Shape: {julia.shape}")
    print(f"Max iterations: {julia.max()}")
    print(f"Min iterations: {julia.min()}")

if __name__ == "__main__":
    main() 