#!/bin/bash

#SBATCH --partition=main          # Partition (job queue)
#SBATCH --requeue                 # Return job to the queue if preempted
#SBATCH --job-name=rdggp-test       # Assign a short name to your job
#SBATCH --nodes=1                 # Number of nodes you require
#SBATCH --ntasks=1                # Total # of tasks across all nodes
#SBATCH --cpus-per-task=1         # Cores per task (>1 if multithread tasks)
#SBATCH --mem=2000                # Real memory (RAM) required (MB)
#SBATCH --time=06:00:00           # Total run time limit (HH:MM:SS)
#SBATCH --output=slurm.%N.%j.out  # STDOUT output file
#SBATCH --error=slurm.%N.%j.err   # STDERR output file (optional)

cd /scratch/$USER/RosettaDDGPrediction/RosettaDDGPrediction/ 

srun rosetta_ddg_aggregate -cr config_run/cartddg2020_ref2015.yaml -ca config_aggregate/aggregate.yaml -cs config_settings/nompi.yaml -d test_output/ -od test_output/aggregate/ -mf test_output/cartesian/mutinfo2.txt -n 6
