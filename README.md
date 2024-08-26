# k-Wave

## Install Guide (Linux)
### 1. Install libraries
Requires at least 8 GiB of RAM (Support Ubuntu, Debian, CentOS) 
```bash
sudo curl -L https://raw.githubusercontent.com/bobqianic/k-Wave/main/install_lib.sh | bash
```
The default install location is `/usr/local`.
If you want to install to a custom location, you can use the following command:
```bash
sudo curl -L https://raw.githubusercontent.com/bobqianic/k-Wave/main/install_lib.sh HDF5_DIR ZLIB_DIR SZIP_DIR | bash
```
### 2. Install k-Wave
Download the latest source code from this repo.

Modify the `CUDA_DIR`, `HDF5_DIR`, `ZLIB_DIR`, and `SZIP_DIR` in the `Makefile` to point to your library installation locations.
```Makefile
CUDA_DIR = "/usr/local/cuda-12.1"
HDF5_DIR = "/usr/local/hdf5"
ZLIB_DIR = "/usr/local/zlib"
SZIP_DIR = "/usr/local/szip"
```

Run make to compile k-Wave.
```bash
make -j $(nproc)
```
