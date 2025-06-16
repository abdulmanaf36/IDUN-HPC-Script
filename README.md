# Running a Slurm Job on NTNU HPC Cluster

This guide will walk you through the steps to submit a job to the NTNU HPC cluster using a Slurm job script. Follow these instructions to run your job in the GPUQ partition (or any other partition) and utilize the resources available on the cluster.

## Prerequisites

* Access to NTNU HPC cluster (IDUN) and an account with necessary permissions.
* A Slurm job script (as detailed below).
* Required software modules (e.g., Python, CUDA) installed or available on the cluster.

## Step-by-Step Instructions

### 1. **Log into the HPC Cluster**

First, you need to log into the NTNU HPC cluster using SSH:

```bash
ssh <username>@idun-login1.hpc.ntnu.no
```

Replace `<username>` with your NTNU username. Once logged in, you can navigate to your project directory or create a new one where you will store the job script.

### 2. **Prepare Your Slurm Job Script**

Create a Slurm job script (e.g., `run_job.slurm`) in the directory where your code is located. This script contains the necessary configurations for your job, such as resource allocation, partition, and modules to load.

### 3. **Check Available Resources**

Before submitting your job, you can check the available resources and partitions on the cluster using the following commands:

* To view the available partitions:

  ```bash
  sinfo
  ```

* To see the list of jobs running or waiting in the queue:

  ```bash
  squeue -u <username>
  ```

Replace `<username>` with your NTNU username to filter your jobs.

### 4. **Submit Your Job**

Once your Slurm job script is ready, submit the job using the `sbatch` command:

```bash
sbatch run_job.slurm
```

This command will submit your job to the Slurm scheduler. The system will allocate resources based on the specifications in your Slurm script (e.g., the GPU type, number of CPU cores, and memory).

### 5. **Monitor Job Status**

To check the status of your job after submission, use the following command:

```bash
squeue -u <username>
```

This will show all the jobs associated with your username, including their status (pending, running, completed, etc.).

### 6. **Access Job Output and Error Logs**

Slurm jobs generate output and error logs which can be useful for debugging and reviewing the results.

* **Output logs**: The output of your job will be stored in the file specified by the `#SBATCH --output=<filename>` directive in your job script. By default, it will be saved in a directory called `logs` with the format `demo_minimal_%j.out` (where `%j` is replaced by the job ID).

* **Error logs**: Similarly, error messages will be logged in the file specified by `#SBATCH --error=<filename>` in your script.

Use the following command to view the output:

```bash
cat logs/out/demo_minimal_<job_id>.out
```

To view any error logs:

```bash
cat logs/err/demo_minimal_<job_id>.err
```

Replace `<job_id>` with the actual job ID assigned by Slurm.

### 7. **Canceling a Job**

If you wish to cancel a job that is running or pending, use the `scancel` command followed by the job ID:

```bash
scancel <job_id>
```

Replace `<job_id>` with the actual job ID.

### 8. **Interactive Jobs (Optional)**

If you need an interactive session (e.g., for testing or debugging), you can request a node for an interactive job:

```bash
salloc --account=<account> --cpus-per-task=1 --partition=GPUQ --time=00:30:00
```

This will allocate a node for 30 minutes with 1 CPU core. After allocation, you can use `ssh` to access the node:

```bash
ssh <node_name>
```

Where `<node_name>` is provided in the output after `salloc` allocation.

### 9. **Using Job Arrays (Optional)**

If you have multiple similar jobs to run, you can submit them as a job array using the `--array` option:

```bash
#SBATCH --array=1-10
```

This will submit 10 sub-jobs, each with a unique `SLURM_ARRAY_TASK_ID`. The job script can be configured to use this ID as part of the execution (e.g., processing different input files).

---

## Helpful Commands

* **Check available resources**: `sinfo`
* **View job queue**: `squeue -u <username>`
* **Cancel a job**: `scancel <job_id>`
* **Submit a job**: `sbatch <job_script>`
* **Interactive session**: `salloc --account=<account> --partition=GPUQ --time=00:30:00`
* **View output logs**: `cat <path_to_logs>/demo_minimal_<job_id>.out`
* **View error logs**: `cat <path_to_logs>/demo_minimal_<job_id>.err`

---

### Conclusion

By following these instructions, you can successfully submit and monitor jobs on the NTNU HPC cluster using Slurm. Always make sure to check the resources available to you and adjust your job script accordingly. If you encounter any issues, check the log files for details or contact the help desk for assistance.