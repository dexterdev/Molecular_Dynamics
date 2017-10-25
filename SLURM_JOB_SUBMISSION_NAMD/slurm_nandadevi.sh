
#!/bin/bash

#SBATCH --nodes=2
#SBATCH --ntasks-per-node=28
#SBATCH --job-name=pH4.5_E39A_300K
#SBATCH --partition=nandaq

#SBATCH --export=all
#SBATCH --mail-type=ALL
#SBATCH --mail-user=devanand.t.1986@gmail.com


cd $SLURM_SUBMIT_DIR
cat $SLURM_JOB_NODELIST > hostfile_$SLURM_JOBID

#MPI Case
module unload intel/2017
module load intel/2015
module load namd/2.10

mpirun -v -np 56 /opt/apps/namd/2.10/namd2 ./2KO2_pH4.5_E39A_300K.config  >& 2KO2_pH4.5_E39A_300K.out
