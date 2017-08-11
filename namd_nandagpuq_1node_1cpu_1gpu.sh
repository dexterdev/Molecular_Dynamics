#!/bin/bash
# for gpu resource add :gpus=1 or :gpus=2 at the end of following line. Likewise for PHI cards add :mics=1 or :mics=2
#PBS -l nodes=1:ppn=1:gpus=1
#PBS -N GPU_TEST
# Available Queuename are: 1) nandaq, 2)nandasq, 3)nandagpuq, 4)nandaphiq
#PBS -q nandagpuq
#PBS -V
#PBS -M devanand.t.1986@gmail.com
#PBS -m abe 
#PBS -j oe

let NP=1*1

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
module load cuda/6.5
./Linux-x86_64-multicore-CUDA/namd2 +p$NP *config >& out_$PBS_JOBID.out

#used Linux-x86_64-multicore-CUDA binary from here http://www.ks.uiuc.edu/Development/Download/download.cgi

#benchmark = Info: Benchmark time: 1 CPUs 0.0145214 s/step 0.0840361 days/ns 241.961 MB memo$
