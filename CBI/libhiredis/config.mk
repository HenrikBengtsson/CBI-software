NAME=hiredis
VERSION=1.4.1
MODULE_NAME=libhiredis

## hiredis ships no ./configure; it is a plain Makefile build
CONFIG=false
DOWNLOAD_TARGET_FILE=Makefile
BUILD_TARGET_FILE=libhiredis.so
## A header, not the .so: shared libraries are executable, which makes the
## generic 'can execute install target, if binary' check try to run it.
INSTALL_TARGET_FILE=include/hiredis/hiredis.h

## This software needs to be built for each Linux distribution separately
LINUX_DISTRO_SPECIFIC=true

CONFIG_MODULES=CBI scl-gcc-toolset
