## Advance

### Use U2CB create your own image

```shell
$ u2cb create -n test-image -b docker://ubuntu
INFO:    Starting build...
Getting image source signatures
Copying blob 6a5697faee43 skipped: already exists
Copying blob ba13d3bc422b skipped: already exists
Copying blob a254829d9e55 skipped: already exists
Copying config 6cd23e40e2 done
Writing manifest to image destination
Storing signatures
2020/10/30 12:30:05  info unpack layer: sha256:6a5697faee43339ef8e33e3839060252392ad99325a48f7c9d7e93c22db4d4cf
2020/10/30 12:30:06  info unpack layer: sha256:ba13d3bc422b493440f97a8f148d245e1999cb616cb05876edc3ef29e79852f2
2020/10/30 12:30:06  info unpack layer: sha256:a254829d9e55168306fd80a49e02eb015551facee9c444d9dce3b26d19238b82
WARNING: The --fix-perms option modifies the filesystem permissions on the resulting container.
INFO:    Creating sandbox directory...
INFO:    Build complete: /u2cb/acct-hpc/hpccsg/containers/test-image
```

```shell
$ u2cb list
['test-image']
$ u2cb connect -n test-image
Singularity> whoami
root
Singularity> apt udpate
...
Singularity> apt install gcc
...
Singularity> gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/9/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none:hsa
OFFLOAD_TARGET_DEFAULT=1
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Ubuntu 9.3.0-17ubuntu1~20.04' --with-bugurl=file:///usr/share/doc/gcc-9/README.Bugs --enable-languages=c,ada,c++,go,brig,d,fortran,objc,obj-c++,gm2 --prefix=/usr --with-gcc-major-version-only --program-suffix=-9 --program-prefix=x86_64-linux-gnu- --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-vtable-verify --enable-plugin --enable-default-pie --with-system-zlib --with-target-system-zlib=auto --enable-objc-gc=auto --enable-multiarch --disable-werror --with-arch-32=i686 --with-abi=m64 --with-multilib-list=m32,m64,mx32 --enable-multilib --with-tune=generic --enable-offload-targets=nvptx-none=/build/gcc-9-HskZEa/gcc-9-9.3.0/debian/tmp-nvptx/usr,hsa --without-cuda-driver --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu
Thread model: posix
gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)
```

```shell
$ u2cb download -n test-image
$ ls
test-image.simg
$ singularity run test-image.simg gcc -v 
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/9/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none:hsa
OFFLOAD_TARGET_DEFAULT=1
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Ubuntu 9.3.0-17ubuntu1~20.04' --with-bugurl=file:///usr/share/doc/gcc-9/README.Bugs --enable-languages=c,ada,c++,go,brig,d,fortran,objc,obj-c++,gm2 --prefix=/usr --with-gcc-major-version-only --program-suffix=-9 --program-prefix=x86_64-linux-gnu- --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-vtable-verify --enable-plugin --enable-default-pie --with-system-zlib --with-target-system-zlib=auto --enable-objc-gc=auto --enable-multiarch --disable-werror --with-arch-32=i686 --with-abi=m64 --with-multilib-list=m32,m64,mx32 --enable-multilib --with-tune=generic --enable-offload-targets=nvptx-none=/build/gcc-9-HskZEa/gcc-9-9.3.0/debian/tmp-nvptx/usr,hsa --without-cuda-driver --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu
Thread model: posix
gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)
```

### Case: add gsl into your image

```shell
$ u2cb create -n test-gsl -b docker://sjtuhpc/hpc-base-container:gcc-8.ompi-4.0
INFO:    Starting build...
Getting image source signatures
Copying blob 6a5697faee43 skipped: already exists
Copying blob ba13d3bc422b skipped: already exists
Copying blob a254829d9e55 skipped: already exists
Copying config 6cd23e40e2 done
Writing manifest to image destination
Storing signatures
2020/10/30 12:30:05  info unpack layer: sha256:6a5697faee43339ef8e33e3839060252392ad99325a48f7c9d7e93c22db4d4cf
2020/10/30 12:30:06  info unpack layer: sha256:ba13d3bc422b493440f97a8f148d245e1999cb616cb05876edc3ef29e79852f2
2020/10/30 12:30:06  info unpack layer: sha256:a254829d9e55168306fd80a49e02eb015551facee9c444d9dce3b26d19238b82
WARNING: The --fix-perms option modifies the filesystem permissions on the resulting container.
INFO:    Creating sandbox directory...
INFO:    Build complete: /u2cb/acct-hpc/hpccsg/containers/test-image
```

```shell
$ u2cb connect -n test-gsl
Singularity> cat /etc/os-release
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

Singularity> yum install -y gsl-devel
...
```

```shell
$ u2cb download -n test-gsl
INFO:    Starting build...
INFO:    Creating SIF file...
INFO:    Build complete: /u2cb/acct-hpc/hpccsg/simg/test-gsl.simg
Connection to 172.16.12.179 closed.
--2020-10-30 13:04:11--  http://172.16.12.179:8080/api/v0.1/download?acct=acct-hpc&user=hpccsg&container_name=test-gsl
Connecting to 172.16.12.179:8080... connected.
HTTP request sent, awaiting response... 200 OK
Length: 234196992 (223M) [application/octet-stream]
Saving to: ‘test-gsl.simg’

100%[=====================>] 234,196,992  179MB/s   in 1.2s

2020-10-30 13:04:12 (179 MB/s) - ‘test-gsl.simg’ saved [234196992/234196992]

Downloaded the container to ./test-gsl.simg.
$ singularity run ~/test-gsl.simg gcc gsl_test.c -o gsl_test -lgsl
$ singularity run ~/test-gsl.simg ./gsl_test
J0(5) = -1.775967713143382642e-01
```
