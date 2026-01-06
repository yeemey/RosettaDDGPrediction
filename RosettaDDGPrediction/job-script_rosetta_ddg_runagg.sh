#!/bin/bash

#SBATCH --partition=main          # Partition (job queue)
#SBATCH --requeue                 # Return job to the queue if preempted
#SBATCH --job-name=dsdna       # Assign a short name to your job
#SBATCH --nodes=1                 # Number of nodes you require
#SBATCH --ntasks=1                # Total # of tasks across all nodes
#SBATCH --cpus-per-task=12         # Cores per task (>1 if multithread tasks)
#SBATCH --mem=10000                # Real memory (RAM) required (MB)
#SBATCH --time=3-00:00:00           # Total run time limit (HH:MM:SS)
#SBATCH --output=slurm.%N.%j.out  # STDOUT output file
#SBATCH --error=slurm.%N.%j.err   # STDERR output file (optional)

cd /scratch/$USER/RosettaDDGPrediction/RosettaDDGPrediction/ 

srun rosetta_ddg_run -p data/3J2M_chainA.pdb -cr config_run/cartddg2020_ref2015.yaml -cs config_settings/nompi.yaml -r /scratch/$USER/rosetta.binary.ubuntu.release-408/ -d output/3J2M_A -l data/3J2M_A_mutations.txt -n 12

srun rosetta_ddg_run -p data/1G31_chainA.pdb -cr config_run/cartddg2020_ref2015.yaml -cs config_settings/nompi.yaml -r /scratch/$USER/rosetta.binary.ubuntu.release-408/ -d output/1G31_A -l data/1G31_A_mutations.txt -n 12

srun rosetta_ddg_run -p data/3J7V_chainA.pdb -cr config_run/cartddg2020_ref2015.yaml -cs config_settings/nompi.yaml -r /scratch/$USER/rosetta.binary.ubuntu.release-408/ -d output/3J7V_A -l data/3J7V_A_mutations.txt -n 12

srun rosetta_ddg_run -p data/7EY7_chainC.pdb -cr config_run/cartddg2020_ref2015.yaml -cs config_settings/nompi.yaml -r /scratch/$USER/rosetta.binary.ubuntu.release-408/ -d output/7EY7_C -l data/7EY7_C_mutations.txt -n 12

srun rosetta_ddg_run -p data/1ARO_chainL.pdb -cr config_run/cartddg2020_ref2015.yaml -cs config_settings/nompi.yaml -r /scratch/$USER/rosetta.binary.ubuntu.release-408/ -d output/1ARO_L -l data/1ARO_L_mutations.txt -n 12

srun rosetta_ddg_run -p data/1NO4_chainA.pdb -cr config_run/cartddg2020_ref2015.yaml -cs config_settings/nompi.yaml -r /scratch/$USER/rosetta.binary.ubuntu.release-408/ -d output/1NO4_A -l data/1NO4_A_mutations.txt -n 12

srun rosetta_ddg_run -p data/3QC7_chainA.pdb -cr config_run/cartddg2020_ref2015.yaml -cs config_settings/nompi.yaml -r /scratch/$USER/rosetta.binary.ubuntu.release-408/ -d output/3QC7_A -l data/3QC7_A_mutations.txt -n 12

srun rosetta_ddg_run -p data/6QVK_chain1A.pdb -cr config_run/cartddg2020_ref2015.yaml -cs config_settings/nompi.yaml -r /scratch/$USER/rosetta.binary.ubuntu.release-408/ -d output/6QVK_1A -l data/6QVK_1_mutations.txt -n 12

srun rosetta_ddg_aggregate -cr config_run/cartddg2020_ref2015.yaml -ca config_aggregate/aggregate.yaml -cs config_settings/nompi.yaml -d output/3J2M_A/ -od output/3J2M_A/aggregate/ -mf output/3J2M_A/cartesian/mutinfo.txt -n 12

srun rosetta_ddg_aggregate -cr config_run/cartddg2020_ref2015.yaml -ca config_aggregate/aggregate.yaml -cs config_settings/nompi.yaml -d output/1G31_A/ -od output/1G31_A/aggregate/ -mf output/1G31_A/cartesian/mutinfo.txt -n 12

srun rosetta_ddg_aggregate -cr config_run/cartddg2020_ref2015.yaml -ca config_aggregate/aggregate.yaml -cs config_settings/nompi.yaml -d output/3J7V_A/ -od output/3J7V_A/aggregate/ -mf output/3J7V_A/cartesian/mutinfo.txt -n 12

srun rosetta_ddg_aggregate -cr config_run/cartddg2020_ref2015.yaml -ca config_aggregate/aggregate.yaml -cs config_settings/nompi.yaml -d output/7EY7_C/ -od output/7EY7_C/aggregate/ -mf output/7EY7_C/cartesian/mutinfo.txt -n 12

srun rosetta_ddg_aggregate -cr config_run/cartddg2020_ref2015.yaml -ca config_aggregate/aggregate.yaml -cs config_settings/nompi.yaml -d output/1ARO_L/ -od output/1ARO_L/aggregate/ -mf output/1ARO_L/cartesian/mutinfo.txt -n 12

srun rosetta_ddg_aggregate -cr config_run/cartddg2020_ref2015.yaml -ca config_aggregate/aggregate.yaml -cs config_settings/nompi.yaml -d output/1NO4_A/ -od output/1NO4_A/aggregate/ -mf output/1NO4_A/cartesian/mutinfo.txt -n 12

srun rosetta_ddg_aggregate -cr config_run/cartddg2020_ref2015.yaml -ca config_aggregate/aggregate.yaml -cs config_settings/nompi.yaml -d output/3QC7_A/ -od output/3QC7_A/aggregate/ -mf output/3QC7_A/cartesian/mutinfo.txt -n 12

srun rosetta_ddg_aggregate -cr config_run/cartddg2020_ref2015.yaml -ca config_aggregate/aggregate.yaml -cs config_settings/nompi.yaml -d output/6QVK_1A/ -od output/6QVK_1A/aggregate/ -mf output/6QVK_1A/cartesian/mutinfo.txt -n 12

