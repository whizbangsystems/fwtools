#!/bin/sh
# TODO -- make sure that whatever's happening in unpack can happen in ubuntu
./fetch.sh
rm -rf tree
./unpack.sh
./copy_overlay.sh
if ! ./mkgdal.sh ; then
  exit 1
fi
if [ -f local.sh ] ; then 
  if ! ./local.sh ; then
    exit 1
  fi
fi

./preparetar.sh
