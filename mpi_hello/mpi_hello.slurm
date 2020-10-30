#!/bin/bash

#SBATCH --job-name=container_mpihello
#SBATCH --partition=small
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH -n 4
#SBATCH --ntasks-per-node=4

srun --mpi=pmi2 singularity run ./hpc-base-container_gcc-8.ompi-4.0.sif ./mpi_hello