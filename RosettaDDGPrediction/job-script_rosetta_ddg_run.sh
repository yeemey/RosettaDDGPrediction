#!/bin/bash

#SBATCH --partition=main          # Partition (job queue)
#SBATCH --requeue                 # Return job to the queue if preempted
#SBATCH --job-name=1al0f       # Assign a short name to your job
#SBATCH --nodes=1                 # Number of nodes you require
#SBATCH --ntasks=1                # Total # of tasks across all nodes
#SBATCH --cpus-per-task=6         # Cores per task (>1 if multithread tasks)
#SBATCH --mem=6000                # Real memory (RAM) required (MB)
#SBATCH --time=3-00:00:00           # Total run time limit (HH:MM:SS)
#SBATCH --output=slurm.%N.%j.out  # STDOUT output file
#SBATCH --error=slurm.%N.%j.err   # STDERR output file (optional)

cd /scratch/$USER/RosettaDDGPrediction/RosettaDDGPrediction/ 

srun rosetta_ddg_run -p data/1AL0_chainF.pdb -cr config_run/cartddg2020_ref2015.yaml -cs config_settings/nompi.yaml -r /scratch/$USER/rosetta.binary.ubuntu.release-408/ -d output/ -l data/1AL0_F_mutations.txt -n 6

