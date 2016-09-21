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
