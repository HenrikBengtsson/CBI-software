NAME=R
VERSION=4.5.1

## This software needs to be built for each Linux distribution separately
LINUX_DISTRO_SPECIFIC=true

CONFIG_OPTS=--enable-memory-profiling --enable-R-shlib --without-recommended-packages
BUILD_TARGET_FILE=bin/exec/R
BUILD_OPTS=-j 4
INSTALL_TARGET_FILE=bin/R
MODULE_NAME=r
OPENJDK_VERSION=1.8.0
