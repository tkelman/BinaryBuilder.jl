#!/bin/sh
# setup script to bootstrap proot
set -e # stop on failure
#cd $(dirname $0)
PROOT_VER=5.1.0
TALLOC_VER=2.1.8
curl -L https://github.com/proot-me/PRoot/archive/v$PROOT_VER.tar.gz | tar -xzf -
curl -L https://www.samba.org/ftp/talloc/talloc-$TALLOC_VER.tar.gz | tar -xzf -
cd talloc-$TALLOC_VER
if [ -e /usr/lib/x86_64-linux-gnu/libtalloc.so.2 ]; then
  cp talloc.h ../PRoot-$PROOT_VER/src
  cd ../PRoot-$PROOT_VER/src
  make -j$(nproc) install LDFLAGS="/usr/lib/x86_64-linux-gnu/libtalloc.so.2" DESTDIR=../../usr/bin
else
  ./configure --disable-python --prefix=../usr
  make -j$(nproc) install
  cp ../usr/include/talloc.h ../PRoot-$PROOT_VER/src
  cd ../PRoot-$PROOT_VER/src
  make -j$(nproc) install LDFLAGS="-L../../usr/lib -ltalloc" DESTDIR=../../usr/bin
fi
cd ../..
rm -rf PRoot-$PROOT_VER talloc-$TALLOC_VER

# switch to centos6:
# mkdir centos6
# curl -L https://github.com/CentOS/sig-cloud-instance-images/raw/CentOS-6/docker/centos-6-docker.tar.xz | tar -C centos6 -xJf -
# cd centos6
# LD_LIBRARY_PATH=$PWD/../usr/lib ../usr/bin/proot -R .
# cd ..
# chmod +w -R centos6

# switch to opensuse 42.1:
# mkdir opensuse421
# curl -L https://github.com/openSUSE/docker-containers-build/raw/openSUSE-42.1/docker/openSUSE-42.1.tar.xz | tar -C opensuse421 -xJf -
# cd opensuse421
# LD_LIBRARY_PATH=$PWD/../usr/lib ../usr/bin/proot -R .
# cd ..
# chmod +w -R opensuse421
