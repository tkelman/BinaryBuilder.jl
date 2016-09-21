#!/bin/sh
# setup script to bootstrap proot
set -e # stop on failure
#cd $(dirname $0)
PROOT_VER=5.1.0
TALLOC_VER=2.1.8
curl -L https://github.com/proot-me/PRoot/archive/v$PROOT_VER.tar.gz | tar -xzf -
curl -L https://www.samba.org/ftp/talloc/talloc-$TALLOC_VER.tar.gz | tar -xzf -
cd talloc-$TALLOC_VER
./configure --disable-python --prefix=../usr
make -j$(nproc) install
cd ../PRoot-$PROOT_VER/src
cp ../../usr/include/talloc.h .
make -j$(nproc) install LDFLAGS="-L../../usr/lib -ltalloc" DESTDIR=../../usr/bin
cd ../..
rm -rf PRoot-$PROOT_VER talloc-$TALLOC_VER

# switch to centos6:
# mkdir centos6
# curl -L https://github.com/CentOS/sig-cloud-instance-images/raw/CentOS-6/docker/centos-6-docker.tar.xz | tar -C centos6 -xJf -
# cd centos6
# ../usr/bin/proot -R .

# switch to opensuse 42.1:
# mkdir opensuse421
# curl -L https://github.com/openSUSE/docker-containers-build/raw/openSUSE-42.1/docker/openSUSE-42.1.tar.xz | tar -C opensuse421 -xJf -
# cd opensuse421
# ../usr/bin/proot -R .
