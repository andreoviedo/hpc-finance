# Compiler
CXX = icc

# Compiler flags
# -Wall: Enable all warnings
# -std=c++11: Use the C++11 standard (adjust if needed)
# -O2: Optimization level 2
# -g: Include debugging information
CXXFLAGS = -Wall -std=c++11 -O2 -g

# Source file
SOURCES = assignment_1_solution.cpp

# Executable name
EXECUTABLE = assignment_1_solution

# Default target: build the executable
all: $(EXECUTABLE)

# Rule to link the executable
$(EXECUTABLE): $(SOURCES)
	$(CXX) $(CXXFLAGS) $(SOURCES) -o $(EXECUTABLE) -lpthread # Link with pthread library

# Target to clean up generated files
clean:
	rm -f $(EXECUTABLE)

# Phony targets (targets that don't represent files)
.PHONY: all clean 