NAME=geos
VERSION=3.10.2 ## Wait with this version until we install R 4.2.0
VERSION=3.9.1
URL_DOWNLOAD=https://trac.osgeo.org/geos/
URL=https://trac.osgeo.org/geos/
DOWNLOAD_FILE=configure
BUILD_TARGET_FILE=tools/geos-config
INSTALL_TARGET_FILE=bin/geos-config

## IMPORTANT:
## geos (>= 3.8.0) requires a modern compiler toolchain, e.g.
##
##  - gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
##
## is too old and results in a 'make check' error on:
##
## *** Error in `*/tests/unit/.libs/lt-geos_unit': free(): invalid pointer: 0x00007ffc0a99d930 ***
##
## This was observed for geos 3.8.1 and geos 3.9.1
##
## module load scl-devtoolset/8 provides:
##
##  - gcc (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3)
##
## which seems to suffice.
CONFIG_MODULES=CBI scl-devtoolset/8
