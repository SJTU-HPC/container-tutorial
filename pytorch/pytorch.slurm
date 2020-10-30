#!/bin/bash
#SBATCH -J pytorch_test
#SBATCH -p dgx2
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1

module purge
module load pytorch/1.6.0

python pytorch_test.slurm