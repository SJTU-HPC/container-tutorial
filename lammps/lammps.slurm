#!/bin/bash
#SBATCH --job-name=lmp_test
#SBATCH --partition=cpu
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH -N 1
#SBATCH --ntasks-per-node=40

module purge
module load lammps/2020-cpu

srun --mpi=pmi2 lmp -i in.eam -var x 1 -var y 1 -var z 1