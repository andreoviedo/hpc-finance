import math
import random
import time
from scipy.stats import norm

def random_data(low, hi):
    r = random.random()
    return low + r * (hi - low)

def norm_cdf(x):
    return 0.5 * (1.0 + math.erf(x / math.sqrt(2.0)))

def european_call_option(S, K, T, r, sigma):
    d1 = (math.log(S/K) + (r + 0.5 * sigma * sigma) * T) / (sigma * math.sqrt(T))
    d2 = d1 - sigma * math.sqrt(T)
    return S * norm_cdf(d1) - K * math.exp(-r * T) * norm_cdf(d2)

def value_option():
    # Example values with random variations
    S = 100.0 + random_data(-5.0, 5.0)      # Stock price
    K = 100.0 + random_data(-5.0, 5.0)      # Strike price
    T = 1.0 + random_data(-0.5, 2.0)        # Time to expiration
    r = 0.05 + random_data(-0.02, 0.15)     # Risk-free rate
    sigma = 0.2 + random_data(-0.15, 0.40)  # Volatility
    
    result = european_call_option(S, K, T, r, sigma)
    return result

def main():
    N = 1000000
    start_time = time.time()
    
    for i in range(N):
        value_option()
    
    end_time = time.time()
    duration = (end_time - start_time) * 1000  # Convert to milliseconds
    
    print(f"Elapsed time: {duration:.2f} ms")

if __name__ == "__main__":
    main()


