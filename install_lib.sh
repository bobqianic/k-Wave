#!/bin/bash

# Define default installation directories
DEFAULT_HDF5_INSTALL_DIR="/usr/local/hdf5"
DEFAULT_ZLIB_INSTALL_DIR="/usr/local/zlib"
DEFAULT_SZIP_INSTALL_DIR="/usr/local/szip"

# Set installation directories to arguments or default values
HDF5_INSTALL_DIR=${1:-$DEFAULT_HDF5_INSTALL_DIR}
ZLIB_INSTALL_DIR=${2:-$DEFAULT_ZLIB_INSTALL_DIR}
SZIP_INSTALL_DIR=${3:-$DEFAULT_SZIP_INSTALL_DIR}

# Function to download and extract tarballs
download_and_extract() {
    url=$1
    output_dir=$2
    filename=$(basename "$url")
    
    wget "$url" -O "$filename"
    tar -xvzf "$filename" -C "$output_dir" --strip-components=1
    rm "$filename"
}

# Install HDF5 Library
echo "Installing HDF5 Library..."
HDF5_URL="https://github.com/HDFGroup/hdf5/releases/download/hdf5_1.14.4.3/hdf5-1.14.4-3.tar.gz"
mkdir -p ./hdf5_src && cd ./hdf5_src/hdf5-1.14.4-3
download_and_extract "$HDF5_URL" .
./configure --enable-hl --enable-static --enable-shared --prefix="$HDF5_INSTALL_DIR"
make -j
make install
cd ..

# Install ZLIB Library
echo "Installing ZLIB Library..."
ZLIB_URL="https://www.zlib.net/zlib-1.3.1.tar.gz"
mkdir -p ./zlib_src && cd ./zlib_src
download_and_extract "$ZLIB_URL" .
./configure --prefix="$ZLIB_INSTALL_DIR"
make -j
make install
cd ..

# Install SZIP Library
echo "Installing SZIP Library..."
SZIP_URL="https://docs.hdfgroup.org/archive/support/ftp/lib-external/szip/2.1.1/src/szip-2.1.1.tar.gz"
mkdir -p ./szip_src && cd ./szip_src
download_and_extract "$SZIP_URL" .
./configure --prefix="$SZIP_INSTALL_DIR"
make -j
make install
cd ..

echo "Installation completed successfully!"
