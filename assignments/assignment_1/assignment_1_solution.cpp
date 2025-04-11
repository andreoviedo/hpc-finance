// Goal of this assignment is to implement a simple program that uses std::thread to demonstrate two patterns:
// The patterns we will implement are:
// - Folk-join
// - Map-reduction

#include <iostream>
#include <thread>
#include <string>
#include <sstream>
#include <chrono>
#include <cmath> // For erf, sqrt, log, exp
#include <numeric> // For std::iota potentially
#include <functional> // For std::ref
#include <algorithm> // For std::max
#include <vector>

// Enum to represent option type
enum class OptionType {
    Call,
    Put
};

// Define the Stock class
class Stock {
public:
    double spot; // Represents the spot price of the stock
    double sigma; // Represents the volatility of the stock

    // Constructor to initialize price and volatility
    Stock(double p = 0.0, double v = 0.0) : spot(p), sigma(v) {}
};

// Define math constants if not available
#ifndef M_SQRT1_2
#define M_SQRT1_2 0.70710678118654752440 // 1/sqrt(2)
#endif

// Class to represent a European Option and calculate its value
class EuropeanOption {
private:
    // Helper function for Normal CDF using erf
    double norm_cdf(double value) const {
        return 0.5 * std::erfc(-value * M_SQRT1_2);
    }

public:
    double strike_price; // K
    double time_to_expiration; // T
    double risk_free_rate; // r
    OptionType type;

    // Constructor
    EuropeanOption(double K, double T, double r, OptionType optType)
        : strike_price(K), time_to_expiration(T), risk_free_rate(r), type(optType) {}

    // Calculate option value using Black-Scholes
    double value(const Stock& stock) const {
        double S = stock.spot;
        double K = strike_price;
        double T = time_to_expiration;
        double r = risk_free_rate;
        double sigma = stock.sigma;

        double d1 = (std::log(S / K) + (r + 0.5 * sigma * sigma) * T) / (sigma * std::sqrt(T));
        double d2 = d1 - sigma * std::sqrt(T);

        double price = 0.0;
        if (type == OptionType::Call) {
            price = S * norm_cdf(d1) - K * std::exp(-r * T) * norm_cdf(d2);
        } else { // Put
            price = K * std::exp(-r * T) * norm_cdf(-d2) - S * norm_cdf(-d1);
        }
        return std::max(0.0, price); // Price cannot be negative
    }
};

int main() {
    // --- Setup ---

    const unsigned int num_threads = std::thread::hardware_concurrency();
    const int num_options = 1000000;
    const int num_stocks = num_threads;
    const double initial_spot = 100.0;
    const double initial_vol = 0.20;
    const double initial_strike = 100.0;
    const double initial_expiry = 1.0;
    const double initial_rate = 0.05;

    std::cout << "Setting up " << num_options << " options for " << num_stocks << " stocks..." << std::endl;

    // Create and initialize stocks
    std::vector<Stock> stocks;
    stocks.reserve(num_stocks);
    for (int i = 0; i < num_stocks; ++i) {
        // Vary parameters slightly for different stocks
        stocks.emplace_back(initial_spot + (i % 5) - 2, initial_vol + (i % 4) * 0.01);
    }

    // Create and initialize options
    std::vector<EuropeanOption> options;
    options.reserve(num_options);
    for (int i = 0; i < num_options; ++i) {
        // Alternate Call/Put and vary parameters slightly
        OptionType type = (i % 2 == 0) ? OptionType::Call : OptionType::Put;
        double strike = initial_strike + (i % 10) - 5;
        double expiry = initial_expiry + (i % 3) * 0.1;
        options.emplace_back(strike, expiry, initial_rate, type);
    }

    // Vector to store results
    std::vector<double> results(num_options);

    std::cout << "Setup complete." << std::endl;

    // --- Fork-Join Implementation ---
    std::cout << "Starting parallel valuation..." << std::endl;
    auto start_time = std::chrono::high_resolution_clock::now();

    // Determine the number of threads
    std::cout << "Using " << num_threads << " threads." << std::endl;

    std::vector<std::thread> threads;
    threads.reserve(num_threads);

    int remaining_options = num_options % num_threads; // Might not be needed anymore

    // Define the worker function (lambda) - Modified to work per stock
    auto worker = [&](int stock_index) {
        // std::cout << "Thread for stock " << stock_index << " starting." << std::endl;
        const Stock& stock = stocks[stock_index]; // Get the single stock for this thread
        // Iterate through options assigned to this stock
        for (int i = stock_index; i < num_options; i += num_stocks) {
            results[i] = options[i].value(stock); // Calculate and store value
        }
        // std::cout << "Thread for stock " << stock_index << " finished." << std::endl;
    };

    // --- Fork ---
    for (int i = 0; i < num_threads; ++i) {
        threads.emplace_back(worker, i);
    }

    // --- Join ---
    for (std::thread& t : threads) {
        if (t.joinable()) {
            t.join();
        }
    }

    auto end_time = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time);

    std::cout << "Valuation complete." << std::endl;
    std::cout << "Total time taken: " << duration.count() << " milliseconds." << std::endl;

    // --- Reduction: Calculate Mean Per Stock & Weighted Average ---
    if (num_options > 0 && num_stocks > 0) {
        std::vector<double> mean_per_stock(num_stocks, 0.0);
        double total_value_all_stocks = 0.0;
        int options_per_stock = num_options / num_stocks; // Assuming even division for simplicity here

        std::cout << "Calculating mean value per stock..." << std::endl;
        for (int s = 0; s < num_stocks; ++s) {
            double sum_for_stock = 0.0;
            int count_for_stock = 0;
            // Iterate through results for this stock
            for (int i = s; i < num_options; i += num_stocks) {
                sum_for_stock += results[i];
                count_for_stock++;
            }

            if (count_for_stock > 0) {
                mean_per_stock[s] = sum_for_stock / count_for_stock;
                std::cout << "  Stock " << s << ": Mean = " << mean_per_stock[s] << std::endl;
            }
             total_value_all_stocks += sum_for_stock; // Accumulate total for overall check
        }

        // Calculate weighted average (equal weights)
        double weighted_mean = 0.0;
        double weight = 1.0 / num_stocks;
        for (double stock_mean : mean_per_stock) {
            weighted_mean += stock_mean * weight;
        }

        // Alternative: Calculate overall mean directly from total sum
        // double overall_mean_direct = total_value_all_stocks / num_options;

        std::cout << "Overall weighted mean option value: " << weighted_mean << std::endl;
        // std::cout << "(Overall mean calculated directly: " << overall_mean_direct << ")" << std::endl;

    } else {
        std::cout << "Not enough options or stocks to calculate mean values." << std::endl;
    }

    // Optional: Print a few results
    // std::cout << "Sample results:" << std::endl;
    // for(int i = 0; i < 5 && i < num_options; ++i) {
    //     std::cout << "Option " << i << ": " << results[i] << std::endl;
    // }

    return 0;
}
