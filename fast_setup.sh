#!/bin/bash

# Change directory to /root
cd /root

# Execute the script from the k-Wave repository
sudo curl -L https://raw.githubusercontent.com/bobqianic/k-Wave/main/install_lib_china.sh | bash

# Download the main zip file from the k-Wave repository
wget https://github.com/bobqianic/k-Wave/archive/refs/heads/main.zip

# Unzip the downloaded file
unzip ./main.zip

# Change directory to the kspaceFirstOrder-CUDA folder
cd ./k-Wave-main/kspaceFirstOrder-CUDA

# Compile the code using all available processors
make -j $(nproc)

# Go back to the /root directory
cd /root

# Create the /root/lanyun-tmp/input directory
mkdir -p /root/lanyun-tmp/input

# Create the torch-kwave directory
mkdir ./torch-kwave

# Change to the torch-kwave directory
cd ./torch-kwave

# Install h5py Python package
python3 -m pip install h5py
