#!/bin/bash

# Change directory to /root/torch-kwave
cd /root/torch-kwave

# Execute the test3.py script
python3 ./test3.py

# Change directory to /root/lanyun-tmp/input
cd /root/lanyun-tmp/input

# Compress the contents of the input directory into a zip file
zip -r /root/lanyun-tmp/input.zip ./

# Move one directory up
cd ..

# Remove the input directory
rm -rf ./input

# Recreate the input directory
mkdir ./input

# Change directory to /root
cd /root

# Change directory to kspaceFirstOrder-CUDA in k-Wave-main
cd ./k-Wave-main/kspaceFirstOrder-CUDA

# Run the run_simulation_compressed.py script
python3 ./run_simulation_compressed.py

# Change directory to /root/lanyun-tmp/output
cd /root/lanyun-tmp/output

# Compress the contents of the output directory into a zip file
zip -r /root/lanyun-tmp/output.zip ./

# Move one directory up
cd ..

# Remove the output directory
rm -rf ./output

# Change directory back to /root
cd /root
