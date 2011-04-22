        	HOWTO Prepare FWTools Binary Distribution
        	=========================================

Notes
------------

This repository is meant to be a fork of Frank Warmerdam's
[FWTools](http://fwtools.maptools.org/linux-experimental.html), tuned
for work with the native java interface. It's young, but please check
back for more information!

After building this and extracting FWTools onto your machine of
choice, the following two lines should get you up and running with the
java bindings.

    export JAVA_OPTS=" $JAVA_OPTS -Djava.library.path=/path/to/*.so-files"
    export LD_LIBRARY_PATH="/path/to/fwtools/usr/lib"

### Problems, TODO:

#### java.opt
`gdal/swig/java/java.opt`, as it exists in the gdal source, is
currently wrong. The line that reads:

    JAVA_HOME = "C:\Program Files\Java\jdk1.6.0_16"

needs to be adjusted, for Linux, to read something like

    JAVA_HOME = "/usr/lib/jvm/java-6-sun-1.6.0.15/"

* `mkgdal`'s method of copying the java native bindings is probably
  faulty.
* No support for non-64 bit architectures.
* Packages aren't bundled up, the way they were with CentOS.

Requirements
------------

The system is intended to be run on an Ubuntu linux system and depends
on core packages as well as (soon!) packages from EPEL and Enterprise
Linux GIS efforts. It has been tested on Ubuntu 10 systems so far.

The scripts, in their current, youthful version, should work fine on
x86_64 (64bit) architectures.

Get Scripts
-----------

    git clone git://github.com/whizbangsystems/fwtools.git
    cd fwtools

Install required packages to build GDAL
---------------------------------------

    ./setupdev.sh

Fetch and Configure GDAL
------------------------

    svn co http://svn.osgeo.org/gdal/branches/1.8/gdal
    cd gdal
    ../gdal_configure.sh
    cd ..

Prepare FWTools
---------------

This step is all that should need to be done for each new release.  It
will refresh rpms, refresh GDAL from svn and refreshes the GDAL build.

edit FW_VERSION as desired.

    ./full_build.sh

Produces FWTools-linux-x86_64-4.0.0.tar.gz.
