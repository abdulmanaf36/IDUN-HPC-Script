#!/bin/bash
#SBATCH --partition=GPUQ                # Use GPU queue
#SBATCH --gres=gpu:1                    # Request 1 GPU (any type)
#SBATCH --nodes=1
#SBATCH --ntasks=1                      # 1 task
#SBATCH --cpus-per-task=1               # 1 CPU thread
#SBATCH --mem=2G                        # 2 GB RAM
#SBATCH --time=00:1:00                 # 10 minutes
#SBATCH --job-name=RunDemo_minimal
#SBATCH --output=logs/out/demo_minimal_%j.out
#SBATCH --error=logs/err/demo_minimal_%j.err

# ── modules & base env ────────────────────────────────────────────────
module purge
module load Anaconda3/2024.02-1
module load CUDA/12.4.0

source activate base

# ── diagnostics ───────────────────────────────────────────────────────
echo "=============================================="
echo "Starting Demo job on $(hostname) at $(date)"
nvidia-smi

# ── move to repo ──────────────────────────────────────────────────────
cd /cluster/home/abdulman/Other_Works/Demo/

# ── run the Python script ─────────────────────────────────────────────
python Demo.py

echo "=============================================="
echo "Demo job completed at $(date)"
echo "=============================================="
