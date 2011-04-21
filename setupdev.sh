#!/bin/sh

PKGLIST="swig ant build-essential libhdf4-dev java-6-openjdk python-dev python2.6-numpy"
sudo apt-get install $PKGLIST

# export LD_LIBRARY_PATH=`pwd`
# Questions -- how the hell to make sure that 
# TODO -- create github repository for this stuff!