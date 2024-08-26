# k-Wave
This version of the k-Wave Toolbox has been modified by bobqianic. The modifications include adding support for the latest hardware and fixing bugs. These modifications are also distributed under the terms of the GNU Lesser General Public License as specified above.

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
```bash
wget https://github.com/bobqianic/k-Wave/archive/refs/heads/main.zip
```

Unzip the souce code.
```bash
unzip ./main.zip
```

Change current directory to `kspaceFirstOrder-CUDA`
```bash
cd ./k-Wave-main/kspaceFirstOrder-CUDA
```

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

## Install Guide (Windows)
### 1. Install libraries & IDE
1. Download Visual Studio 2022 (https://visualstudio.microsoft.com/vs/) and install the `Desktop development with C++` workload.
>
2. Download and unzip VCPKG source code (https://github.com/microsoft/vcpkg). Run the `bootstrap-vcpkg.bat` in the folder to compile vcpkg and generate the executable file.
>
3. Run `./vcpkg.exe install --triplet x64-windows hdf5 zlib szip` in PowerShell to install libraries.

### 2. Install k-Wave
1. Modify `kspaceFirstOrder-CUDA.vcxproj`. Replace `"$(VCTargetsPath)\BuildCustomizations\CUDA 12.4.props"` and `"$(VCTargetsPath)\BuildCustomizations\CUDA 12.4.targets"` to your CUDA Toolkit version.

For example, if your CUDA Toolkit version is `12.6.X`:
```
"$(VCTargetsPath)\BuildCustomizations\CUDA 12.4.props" -> "$(VCTargetsPath)\BuildCustomizations\CUDA 12.6.props"
"$(VCTargetsPath)\BuildCustomizations\CUDA 12.4.targets" -> "$(VCTargetsPath)\BuildCustomizations\CUDA 12.6.targets"
```
>
2. Add new CUDA architecture for you GPU to `<CodeGeneration>` section if its a newer GPU (B100, B200, RTX5090, etc.)
```
<CodeGeneration>compute_50,sm_50;compute_52,sm_52;compute_60,sm_60;compute_61,sm_61;compute_70,sm_70;compute_75,sm_75;compute_80,sm_80;compute_86,sm_86;compute_89,sm_89;compute_90,sm_90;</CodeGen
```
>
3. If you encounter error `LNK1811: cannot open input file 'libszip.lib'/'libhdf5.lib'...`, please remove them from `Properties->Linker->Input->Additional Dependencies`.
