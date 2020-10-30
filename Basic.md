# Basic 

```shell
git clone https://github.com/SJTU-HPC/container-tutorial.git
cd ~/container-tutorial
```

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
$ ls
ubuntu_latest.sif
```

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

```shell
Singularity> apt update
Reading package lists... Done
E: List directory /var/lib/apt/lists/partial is missing. - Acquire (30: Read-only file system)
```

https://hub.docker.com/repository/docker/sjtuhpc/hpc-base-container

```shell
$ singularity pull docker://sjtuhpc/hpc-base-container:gcc-8.ompi-4.0
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
Getting image source signatures
Copying blob f34b00c7da20 skipped: already exists
Copying blob 4abecf7a7b1e done
Copying blob 14d4726ab663 done
Copying blob 36744546b284 done
Copying blob b45bb8a22c1e done
Copying blob 250d99fb66f7 done
Copying config b785527bc5 done
Writing manifest to image destination
Storing signatures
2020/10/30 10:31:46  info unpack layer: sha256:f34b00c7da207ce777a45a37b1241d61bd613c43e3f7c017ceea736bc919c365
2020/10/30 10:31:47  warn rootless{usr/bin/newgidmap} ignoring (usually) harmless EPERM on setxattr "security.capability"
2020/10/30 10:31:47  warn rootless{usr/bin/newuidmap} ignoring (usually) harmless EPERM on setxattr "security.capability"
2020/10/30 10:31:47  warn rootless{usr/bin/ping} ignoring (usually) harmless EPERM on setxattr "security.capability"
2020/10/30 10:31:48  warn rootless{usr/sbin/arping} ignoring (usually) harmless EPERM on setxattr "security.capability"
2020/10/30 10:31:48  warn rootless{usr/sbin/clockdiff} ignoring (usually) harmless EPERM on setxattr "security.capability"
2020/10/30 10:31:49  info unpack layer: sha256:4abecf7a7b1e878de24ab3a10f8f1c2d14c2a7411c4e209c103289e0dc9b4480
2020/10/30 10:31:51  info unpack layer: sha256:14d4726ab663d963925861c176db370f2e5a99d4e3a283cb15cfb562fa97fb85
2020/10/30 10:31:52  warn rootless{usr/bin/ssh-agent} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2020/10/30 10:31:52  warn rootless{usr/bin/wall} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2020/10/30 10:31:52  warn rootless{usr/libexec/openssh/ssh-keysign} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2020/10/30 10:31:53  info unpack layer: sha256:36744546b28479d46ea48ad08babed5f07c636956fd5d192780243e79121f010
2020/10/30 10:31:53  info unpack layer: sha256:b45bb8a22c1e319bbee184899be8d154f18ff019901490dc8663348af3972a5f
2020/10/30 10:31:54  info unpack layer: sha256:250d99fb66f74422b396fede2739177c91a261f52914d5e1da2a0f169089daff
INFO:    Creating SIF file...
INFO:    Build complete: hpc-base-container_gcc-8.ompi-4.0.sif
$ ls
hpc-base-container_gcc-8.ompi-4.0.sif  ubuntu_latest.sif
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
Rank 0 of 4 has pid xxxxx on casxxx.pi.sjtu.edu.cn
Rank 2 of 4 has pid xxxxx on casxxx.pi.sjtu.edu.cn
Rank 1 of 4 has pid xxxxx on casxxx.pi.sjtu.edu.cn
Rank 3 of 4 has pid xxxxx on casxxx.pi.sjtu.edu.cn
```

## Official Image

Support App List

1. gromacs (cpu, dgx2)
1. lammps (cpu, dgx2)
1. relion (cpu, dgx2)
1. octave (gui)
1. scilab (gui)
1. openfoam (cpu)
1. quantum-espresso (cpu)
1. pytorch (dgx2)
1. tensorflow (dgx2)

### Case: Lammps

```shell
$ cd lammps
$ sbatch lammps.slurm
```

### Case: PyTorch

```shell
$ cd pytorch
$ sbatch pytorch.slurm
```