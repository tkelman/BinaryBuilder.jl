#!/bin/sh
# setup script to bootstrap proot
set -e # stop on failure
#cd $(dirname $0)
curl -L https://github.com/proot-me/PRoot/archive/v5.1.0.tar.gz | tar -xzf -
curl -L https://www.samba.org/ftp/talloc/talloc-2.1.8.tar.gz | tar -xzf -
