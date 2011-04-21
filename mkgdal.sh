#!/bin/sh

rm -f gdal/gcore/gdal_version.h
(cd gdal ; svn update)

# set gdal_version.h
python fwpreinstall.py

cd gdal
if ! make install ; then
  exit 1 
fi
cd ..

#this is the last thing I need to change to mess with the java bindings!
# we need to build with the system python so local Python.h is found, but 
# install with the FWTools python so the install goes into the FWTools tree.
(cd gdal/swig/python ; make clean ; /usr/bin/python setup.py build)
(cd gdal/swig/python ; ../../../tree/usr/bin/python setup.py install)
cp gdal/swig/python/scripts/*.py tree/usr/bin

# java version!
(cd gdal/swig/java ; make clean ; /usr/bin/python setup.py build)
(cd gdal/swig/java ; ../../../tree/usr/bin/python setup.py install)
cp gdal/swig/python/scripts/*.py tree/usr/bin

# We have to write java.opt, here, with a totally custom file! We're just going to force a 64-bit biznazz.
# 