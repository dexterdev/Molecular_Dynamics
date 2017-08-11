#!/bin/bash
# for gpu resource add :gpus=1 or :gpus=2 at the end of following line. Likewise for PHI cards add :mics=1 or :mics=2
#PBS -l nodes=16:ppn=16
#PBS -N process_name
# Available Queuename are: 1) nandaq, 2)nandasq, 3)nandagpuq, 4)nandaphiq
#PBS -q nandaq
#PBS -V
#PBS -M email_id
#PBS -m abe
#PBS -j oe

let NP=16*16

ARGS="+strategy USE_GRID"

cd $PBS_O_WORKDIR

nodes=`cat $PBS_NODEFILE`
for n in $nodes; do
echo -e ",$n 16\c" >> tmp.nodes
done
cat tmp.nodes |cut -c2- > PBS_NODEFILE_$PBS_JOBID
rm -rf tmp.nodes

#MPI Case
module load intel/2015
module load namd/2.10

mpirun -v -np $NP /opt/apps/namd/2.10/namd2 *config  >& out
