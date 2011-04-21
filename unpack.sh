#!/bin/sh

mkdir -p tree
cd tree

# TODO -- recreate this for ubuntu, with apt-get!
for x in ../rpms/*.rpm ; do
  echo Unpack: $x
  rpm2cpio $x | cpio -id --quiet
done


