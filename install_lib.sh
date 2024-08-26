#!/bin/bash

# Define default installation directories
DEFAULT_HDF5_INSTALL_DIR="/usr/local/hdf5"
DEFAULT_ZLIB_INSTALL_DIR="/usr/local/zlib"
DEFAULT_SZIP_INSTALL_DIR="/usr/local/szip"

# Set installation directories to arguments or default values
HDF5_INSTALL_DIR=${1:-$DEFAULT_HDF5_INSTALL_DIR}
ZLIB_INSTALL_DIR=${2:-$DEFAULT_ZLIB_INSTALL_DIR}
SZIP_INSTALL_DIR=${3:-$DEFAULT_SZIP_INSTALL_DIR}

# Function to install dependencies
install_dependencies() {
    if [ -x "$(command -v apt-get)" ]; then
        echo "Detected Ubuntu/Debian. Installing dependencies..."
        sudo apt-get update
        sudo apt-get install -y wget build-essential
    elif [ -x "$(command -v yum)" ]; then
        echo "Detected CentOS/RedHat. Installing dependencies..."
        sudo yum install -y wget gcc gcc-c++ make
    else
        echo "Unsupported OS. Please install dependencies manually."
        exit 1
    fi
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to download and extract tarballs
download_and_extract() {
    url=$1
    output_dir=$2
    filename=$(basename "$url")
    
    echo "Downloading $filename..."
    wget "$url" -O "$filename"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download $filename."
        exit 1
    fi
    
    echo "Extracting $filename..."
    mkdir -p "$output_dir"
    tar -xvzf "$filename" -C "$output_dir" --strip-components=1
    if [ $? -ne 0 ]; then
        echo "Error: Failed to extract $filename."
        exit 1
    fi
    
    rm "$filename"
}

# Function to compile and install libraries
compile_and_install() {
    configure_command=$1
    make_command="make -j$(nproc)"
    
    echo "Configuring..."
    $configure_command
    if [ $? -ne 0 ]; then
        echo "Error: Configuration failed."
        exit 1
    fi
    
    echo "Compiling..."
    $make_command
    if [ $? -ne 0 ]; then
        echo "Error: Compilation failed."
        exit 1
    fi
    
    echo "Installing..."
    make install
    if [ $? -ne 0 ]; then
        echo "Error: Installation failed."
        exit 1
    fi
}

# Check for necessary tools
for tool in wget tar make gcc; do
    if ! command_exists "$tool"; then
        echo "$tool is not installed. Installing dependencies..."
        install_dependencies
        break
    fi
done

# Install HDF5 Library
echo "Installing HDF5 Library..."
HDF5_URL="https://github.com/HDFGroup/hdf5/releases/download/hdf5_1.14.4.3/hdf5-1.14.4-3.tar.gz"
mkdir -p ./hdf5_src && cd ./hdf5_src
download_and_extract "$HDF5_URL" .
compile_and_install "./hdf5-1.14.4-3/configure --enable-hl --enable-static --enable-shared --prefix="$HDF5_INSTALL_DIR""
cd ..

# Install ZLIB Library
echo "Installing ZLIB Library..."
ZLIB_URL="https://www.zlib.net/zlib-1.3.1.tar.gz"
mkdir -p ./zlib_src && cd ./zlib_src
download_and_extract "$ZLIB_URL" .
compile_and_install "./configure --prefix="$ZLIB_INSTALL_DIR""
cd ..

# Install SZIP Library
echo "Installing SZIP Library..."
SZIP_URL="https://docs.hdfgroup.org/archive/support/ftp/lib-external/szip/2.1.1/src/szip-2.1.1.tar.gz"
mkdir -p ./szip_src && cd ./szip_src
download_and_extract "$SZIP_URL" .
compile_and_install "./configure --prefix="$SZIP_INSTALL_DIR""
cd ..

echo "Installation completed successfully!"

