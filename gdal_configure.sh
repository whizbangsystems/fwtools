#!/bin/sh

if [ `arch` == "x86_64" ] ; then
  SIXTYFOUR=64
fi

PREFIX=`pwd`/../tree

./configure --prefix=$PREFIX/usr \
    --libdir=$PREFIX/usr/lib$SIXTYFOUR \
    --with-threads \
	--disable-netcdf \
    --disable-fortran \
	--without-odbc \
    --with-geotiff=internal \
    --with-libtiff=internal \
    --with-hdf4

