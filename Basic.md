## Basic

### Introduction to Singularity

Singularity is a container platform. It allows you to create and run containers that package up pieces of software in a way that is portable and reproducible. You can build a container using Singularity on your laptop, and then run it on many of the largest HPC clusters in the world, local university or company clusters, a single server, in the cloud, or on a workstation down the hall. Your container is a single file, and you don’t have to worry about how to install all the software you need on each different operating system.

> [color=#1ca315] More information please refer to [https://sylabs.io/guides/3.6/user-guide/introduction.html](https://sylabs.io/guides/3.6/user-guide/introduction.html).

### Create Your First Container

You can visit [GitHub Page of this Tutorial](https://github.com/SJTU-HPC/container-tutorial.git) for all documents and mateials.

Now please `ssh login.hpc.sjtu.edu.cn` to login into PI 2.0 and clone the GitHub Repo.

```shell
git clone https://github.com/SJTU-HPC/container-tutorial.git
cd ~/container-tutorial
```

You can use `singularity version` to check the version of Singularity on PI 2.0. For the basic usage of singualrity, you can visit [https://sylabs.io/guides/3.6/user-guide/index.html](https://sylabs.io/guides/3.6/user-guide/index.html).

`singularity help` gives an overview of Singularity options and subcommands. For additional help or support, please visit [https://www.sylabs.io/docs/](https://sylabs.io/guides/3.6/user-guide/quick_start.html#overview-of-the-singularity-interface). 

Singularity can make use of public images available from the Docker Hub. By specifying the docker:// URI for an image that has already been located, Singularity can pull it - e.g.:

```shell
$ singularity pull docker://ubuntu
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
Getting image source signatures
Copying blob 6a5697faee43 done
Copying blob ba13d3bc422b done
Copying blob a254829d9e55 done
Copying config 6cd23e40e2 done
Writing manifest to image destination
Storing signatures
2020/10/30 10:23:28  info unpack layer: sha256:6a5697faee43339ef8e33e3839060252392ad99325a48f7c9d7e93c22db4d4cf
2020/10/30 10:23:29  info unpack layer: sha256:ba13d3bc422b493440f97a8f148d245e1999cb616cb05876edc3ef29e79852f2
2020/10/30 10:23:29  info unpack layer: sha256:a254829d9e55168306fd80a49e02eb015551facee9c444d9dce3b26d19238b82
INFO:    Creating SIF file...
INFO:    Build complete: ubuntu_latest.sif
```

You can use `cat /etc/os-release` to check the verion of OS (Operating System). The OS of PI2.0 node is **centos 7**.

```shell
$ cat /etc/os-release
NAME="CentOS Linux"
VERSION="7 (Core)"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="7"
PRETTY_NAME="CentOS Linux 7 (Core)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:7"
HOME_URL="https://www.centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"

CENTOS_MANTISBT_PROJECT="CentOS-7"
CENTOS_MANTISBT_PROJECT_VERSION="7"
REDHAT_SUPPORT_PRODUCT="centos"
REDHAT_SUPPORT_PRODUCT_VERSION="7"
```

When you use `singularity shell` to enter Singualrity container, you can see that 

* You can still read and write your home directory.
* User contexts maintain when the container is launched.
* Operating System switch to Ubuntu.

```shell
$ singularity shell ./ubuntu_latest.sif
Singularity> pwd
/lustre/home/acct-xxx/xxx/container-tutorial
Singularity> whoami
xxx
Singularity> cat /etc/os-release
NAME="Ubuntu"
VERSION="20.04.1 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.1 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
```

The Singularity Image is `read-only`, so you can not modify the content of the image.

```shell
Singularity> apt update
Reading package lists... Done
E: List directory /var/lib/apt/lists/partial is missing. - Acquire (30: Read-only file system)
```

### Use Singularity on PI 2.0

In this section, we show how to use Singularity on PI 2.0 with an example of *MPI Hello World*.

The first step, `pull` MPI Container from Docker Hub. We maintain the HPC base container for PI 2.0 on [Docker Hub](https://hub.docker.com/r/sjtuhpc/hpc-base-container/tags).

```shell
$ cd mpi_hello
$ singularity pull docker://sjtuhpc/hpc-base-container:gcc-8.ompi-4.0
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
Getting image source signatures
Copying blob f34b00c7da20 skipped: already exists
Writing manifest to image destination
Storing signatures
INFO:    Creating SIF file...
INFO:    Build complete: hpc-base-container_gcc-8.ompi-4.0.sif

$ ls hpc-base-container_gcc-8.ompi-4.0.sif
hpc-base-container_gcc-8.ompi-4.0.sif
```

Check the version of gnu compiler and mpi.

```shell
$ singularity run ./hpc-base-container_gcc-8.ompi-4.0.sif gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/opt/rh/devtoolset-8/root/usr/libexec/gcc/x86_64-redhat-linux/8/lto-wrapper
Target: x86_64-redhat-linux
Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,lto --prefix=/opt/rh/devtoolset-8/root/usr --mandir=/opt/rh/devtoolset-8/root/usr/share/man --infodir=/opt/rh/devtoolset-8/root/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --with-linker-hash-style=gnu --with-default-libstdcxx-abi=gcc4-compatible --enable-plugin --enable-initfini-array --with-isl=/builddir/build/BUILD/gcc-8.3.1-20190311/obj-x86_64-redhat-linux/isl-install --disable-libmpx --enable-gnu-indirect-function --with-tune=generic --with-arch_32=x86-64 --build=x86_64-redhat-linux
Thread model: posix
gcc version 8.3.1 20190311 (Red Hat 8.3.1-3) (GCC)

$ singularity run ./hpc-base-container_gcc-8.ompi-4.0.sif mpirun -V
mpirun (Open MPI) 4.0.5

Report bugs to http://www.open-mpi.org/community/help/
```

Compile `mpi_hello.c` and submit the job to `small` node through slurm.

```shell
$ singularity run ./hpc-base-container_gcc-8.ompi-4.0.sif mpicc -o mpi_hello mpi_hello.c
$ cat mpi_hello.slurm
#!/bin/bash

#SBATCH --job-name=container_mpihello
#SBATCH --partition=small
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH -n 4
#SBATCH --ntasks-per-node=4

srun --mpi=pmi2 singularity run ./hpc-base-container_gcc-8.ompi-4.0.sif ./mpi_hello

$ sbatch mpi_hello.slurm
$ cat {xxxxxx}.out
Rank 0 of 4 has pid {xxxx} on cas{xxx}.pi.sjtu.edu.cn
Rank 2 of 4 has pid {xxxx} on cas{xxx}.pi.sjtu.edu.cn
Rank 1 of 4 has pid {xxxx} on cas{xxx}.pi.sjtu.edu.cn
Rank 3 of 4 has pid {xxxx} on cas{xxx}.pi.sjtu.edu.cn
```

### Official Containers on PI 2.0

#### Support Applications

All officially supported applications are listed below:

| Application | Version  | Platform |
| ----------- | -------- | -------- |
| Gromacs     | ![](https://img.shields.io/badge/version-2020-yellowgreen?style=flat-square)     | ![](https://img.shields.io/badge/CPU-blue?style=flat-square) ![](https://img.shields.io/badge/DGX2-green?style=flat-square)    |
| Lammps     | ![](https://img.shields.io/badge/version-3Mar2020-yellowgreen?style=flat-square)     | ![](https://img.shields.io/badge/CPU-blue?style=flat-square) ![](https://img.shields.io/badge/DGX2-green?style=flat-square)     |
| Relion     | ![](https://img.shields.io/badge/version-3.0.8-yellowgreen?style=flat-square)     | ![](https://img.shields.io/badge/CPU-blue?style=flat-square) ![](https://img.shields.io/badge/DGX2-green?style=flat-square) ![](https://img.shields.io/badge/Studio-inactive?style=flat-square)     |
| OpenFOAM     | ![](https://img.shields.io/badge/version-6%20%7C%208-yellowgreen?style=flat-square)     | ![](https://img.shields.io/badge/CPU-blue?style=flat-square)     |
| Quantum Espresso     | ![](https://img.shields.io/badge/version-6.6-yellowgreen?style=flat-square)     | ![](https://img.shields.io/badge/CPU-blue?style=flat-square)     |
| PyTorch     | ![](https://img.shields.io/badge/version-1.4.0%20%7C%201.5.0%20%7C%201.6.0-yellowgreen?style=flat-square)     | ![](https://img.shields.io/badge/DGX2-green?style=flat-square)     |
| TensorFlow     | ![](https://img.shields.io/badge/version-1.15.3%20%7C%202.1.0%20%7C%202.2.0-yellowgreen?style=flat-square)     | ![](https://img.shields.io/badge/DGX2-green?style=flat-square)     |
| Octave     | ![](https://img.shields.io/badge/version-5.2.0-yellowgreen?style=flat-square)     | ![](https://img.shields.io/badge/Studio-inactive?style=flat-square)     |
| Scilab     | ![](https://img.shields.io/badge/version-6.6-yellowgreen?style=flat-square)     | ![](https://img.shields.io/badge/Studio-inactive?style=flat-square)     |


#### Usage

You have two ways to use these official applications containers.

##### 1. Use `module load`

You can use `module av` to list all environment modules and the official applications containers are listed in `/lustre/share/singularity/modules`.

Just `module load` the application modules and run with the entrypoint of the application.

```shell
$ module load lammps/2020-dgx
$ lmp ...
```

##### 2. Directly use the Singularity images

All Singularity images of the application are stored in `/lustre/share/singularity/modules`. So you can use the Singularity images directly with is typical useful for interaction operations.

```shell
$ singularity shell /lustre/share/singularity/modules/openfoam/8.sif
Singularity> source /opt/OpenFOAM-8/etc/bashrc
Singularity> wmake
```

#### Case 1: Lammps

Large-scale Atomic/Molecular Massively Parallel Simulator (LAMMPS) is a software application designed for molecular dynamics simulations. 

While use the official container module, you need not any modify for your slurm scripts.

```shell
$ cd lammps
$ cat lammps.slurm
#!/bin/bash
#SBATCH --job-name=lmp_test
#SBATCH --partition=cpu
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH -N 1
#SBATCH --ntasks-per-node=40

module purge
module load lammps/2020-cpu

srun --mpi=pmi2 lmp -i in.eam -var x 1 -var y 1 -var z 1

$ sbatch lammps.slurm
```


#### Case 2: PyTorch

PyTorch is a GPU accelerated tensor computational framework with a Python frontend. Functionality can be easily extended with common Python libraries such asNumPy, SciPy, and Cython. Automatic differentiation is done with a tape-based system at both a functional and neural network layer level. This functionality brings a high level of flexibility and speed as a deep learning framework and provides accelerated NumPy-like functionality.

While use the official **PyTorch** container module, you need not any modify for your slurm scripts.

```shell
$ cd pytorch
$ cat pytorch.slurm
#!/bin/bash
#SBATCH -J pytorch_test
#SBATCH -p dgx2
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1

module purge
module load pytorch/1.6.0

python pytorch_test.slurm

$ sbatch pytorch.slurm
```
