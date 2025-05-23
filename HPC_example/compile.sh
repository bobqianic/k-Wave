#!/bin/bash
#PBS -l select=1:ncpus=8:mem=64gb:ngpus=1:gpu_type=L40S
#PBS -l walltime=00:10:00
#PBS -N Kwave_Compile_Test


module load tools/prod
module load buildenv/default-foss-2023a-CUDA-12.1.1
module load HDF5/1.14.0-gompi-2023a
module load gompi/2023a

# Copy source + input file to $TMPDIR
cp -r $HOME/k-Wave-EasyBuild-Imperial/kspaceFirstOrder-CUDA $TMPDIR/
cp -r $HOME/k-Wave-EasyBuild-Imperial/HPC_example/input_100_ffca869b-dad8-4bba-b940-97a7fab8a594.h5 $TMPDIR/kspaceFirstOrder-CUDA

# Compile
cd $TMPDIR/kspaceFirstOrder-CUDA
make -j $(nproc)

# Test
$TMPDIR/kspaceFirstOrder-CUDA/kspaceFirstOrder-CUDA -i input_100_ffca869b-dad8-4bba-b940-97a7fab8a594.h5 -o input_100_ffca869b-dad8-4bba-b940-97a7fab8a594_out.h5

# Copy Binary to $HOME
cp $TMPDIR/kspaceFirstOrder-CUDA/kspaceFirstOrder-CUDA $HOME/kspaceFirstOrder-CUDA_bin



