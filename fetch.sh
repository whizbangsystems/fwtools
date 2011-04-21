#!/bin/sh

if [ `arch` == "i686" ] ; then
  PGVER=84
fi

mkdir -p rpms
cd rpms
yumdownloader --resolve \
    python numpy sqlite expat mysql openssl openldap \
    proj proj-epsg proj-nad netcdf ogdi hdf5 libjpeg \
    postgresql${PGVER}-libs \
    krb5-libs keyutils-libs libselinux libsepol \
    curl atlas xerces-c \
    libpng geos cfitsio giflib
cd ..

rm -f rpms/*i686*
if [ `arch` == "x86_64" ] ; then
  rm -f rpms/*i386*
fi

