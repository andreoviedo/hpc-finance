#!/bin/bash

#SBATCH --job-name=assignment_1_run  # Job name
#SBATCH --output=assignment_1_run_%j.out # Standard output and error log (%j expands to jobId)
#SBATCH --time=00:30:00             # Time limit hrs:min:sec
#SBATCH --nodes=1                   # Run on a single node
#SBATCH --ntasks=1                  # Run on a single task
#SBATCH --cpus-per-task=24           # Number of CPU cores per task
#SBATCH --account=finm32950         # Account name

# Optional: Load necessary modules (if icc isn't loaded by default)
module load intel # Adjust this line if needed based on your cluster's module system

# Navigate to the directory where the script is located (or where the Makefile is)
cd $SLURM_SUBMIT_DIR

echo "Job started on $(hostname) at $(date)"
echo "SLURM Job ID: ${SLURM_JOB_ID}"
echo "Requested ${SLURM_CPUS_PER_TASK} cores."

# Build the code (optional: run make clean first)
echo "Building the executable..."
make clean
make

# Check if make was successful
if [ $? -ne 0 ]; then
  echo "Make failed, exiting."
  exit 1
fi

# Run the executable
echo "Running the executable..."
./assignment_1_solution

echo "Job finished at $(date)." 