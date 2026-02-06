NAME=R
VERSION=4.5.2

## This software needs to be built for each Linux distribution separately
LINUX_DISTRO_SPECIFIC=true

CONFIG_OPTS=--enable-memory-profiling --enable-R-shlib --without-recommended-packages
CONFIG_OPTS=--enable-memory-profiling --enable-R-shlib --without-recommended-packages --with-x=no
BUILD_TARGET_FILE=bin/exec/R
BUILD_OPTS=-j 4
INSTALL_TARGET_FILE=bin/R
MODULE_NAME=r
OPENJDK_VERSION=1.8.0
OPENJDK_VERSION=25

CONFIG_MODULES=CBI scl-gcc-toolset

DEPENDS_ON=bzip2-devel libcurl-devel readline-devel ncurses-devel libpcre2-devel libicu-devel getttext-devel libpng-devel libjpeg-turbo-devel libtiff-devel libcairo-devel 
