#!/bin/bash

#PBS -l nodes=12:ncpus=8
#PBS -N POLY_ALA_salt
#PBS -q workq
#PBS -V
#PBS -M devanandt@imsc.res.in
#PBS -m abe 
#PBS -j oe

cd $PBS_O_WORKDIR



######Create the machinefile according the nodes allocated###############
nodes=`cat $PBS_NODEFILE`
for n in $nodes; do
echo -e ",$n 8\c" >> tmp.nodes
done
cat tmp.nodes |cut -c2- > PBS_NODEFILE_$PBS_JOBID
rm -rf tmp.nodes
#############Your application command line#########################

export  MPI_DSM_DISTRIBUTE=1
NODEFILE=PBS_NODEFILE_$PBS_JOBID

#MPI Case
#module load intel/2015
#module load namd/2.10

mpirun -v -f $NODEFILE /opt/app/namd/2.9/namd2 /lustre/devanandt/NAMD/PEPTIDE_EXPERIMENTS/POLY_ALA12_NaCl_ions/poly-ala.config  >& out_$PBS_JOBID.out
