# k-Wave
This version of the k-Wave Toolbox has been modified by bobqianic. The modifications include adding support for the latest hardware and fixing bugs. These modifications are also distributed under the terms of the GNU Lesser General Public License as specified above.

## Install Guide (Imperial HPC)
### 1. Install k-Wave
Download the latest source code from this repo.
```bash
wget -O k-Wave-EasyBuild-Imperial.zip https://github.com/bobqianic/k-Wave/archive/refs/heads/EasyBuild-Imperial.zip 
```

Unzip the souce code.
```bash
unzip ./k-Wave-EasyBuild-Imperial.zip
```

Run qsub to submit and compile k-Wave.
```bash
qsub ./k-Wave-EasyBuild-Imperial/HPC_example/compile.sh
```

Once the job is finished, you will see the compiled binary `kspaceFirstOrder-CUDA_bin` in your `$HOME` directory. 

> [!NOTE]
> This is just a very simple example. You can modify the example job file as you like, but if you want to compile from source, make sure it includes the following modules
> ```
> module load tools/prod
> module load buildenv/default-foss-2023a-CUDA-12.1.1
> module load HDF5/1.14.0-gompi-2023a
> module load gompi/2023a
> ```


## C++ vs MATLAB performance
![image](https://github.com/bobqianic/k-Wave/blob/main/Performance.png?raw=true)
