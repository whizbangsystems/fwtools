#!/bin/sh

if test ! -d tree ; then
  echo 
  echo "FWTools tree directory not found."
  exit 1
fi

VER=`cat FW_VERSION`

ARCH=`arch`
NAME=FWTools-linux-${ARCH}-${VER}

# clean away compiled python - no need for it.

echo "Cleanup compiled python files." 

find tree -name "*.pyc" -exec rm {} \;

# Clean some stuff that isn't worth distributing.

echo "Trim some bulky, unneeded stuff from installed packages."

rm -rf usr/share/doc/hdf5*
rm -rf usr/share/doc/cfits*
rm -rf usr/share/doc/python-setuptools*
rm -rf usr/share/doc/openssl*
rm -rf usr/lib*/python2.4/distutils
rm -rf usr/lib*/python2.4/site-packages/numpy/distutils

# We want to strip the rpath out of executables and libraries so the
# fwtools version of shared libraries are used in preference to system ones.

echo "Stripping rpath..."

for file in tree/usr/bin/* ; do 
  chrpath -d $file > /dev/null 2>&1 
done

for file in tree/usr/lib*/* ; do 
  chrpath -d $file > /dev/null 2>&1
done

echo "Cleaning..."
rm -rf  tree/bin_safe
rm -f tree/fwtools_env.*
rm -f $NAME.tar $NAME.tar.gz

mv tree $NAME

echo "Creating Tar file ${NAME}.tar..."
tar cf ${NAME}.tar ./${NAME}

mv ${NAME} tree

echo "Gzipping..."
gzip -9 ${NAME}.tar

echo "Re-installing"
cd tree
./install.sh

echo "${NAME}.tar.gz now ready."


