NAME=R
VERSION:=4.1.2
URL_DOWNLOAD=https://cran.r-project.org/
URL=https://cran.r-project.org/src/base/R-4/
CONFIG_OPTS=--enable-memory-profiling --enable-R-shlib --without-recommended-packages
BUILD_TARGET_FILE=bin/exec/R
BUILD_OPTS=-j 4
INSTALL_TARGET_FILE=bin/R
MODULE_NAME=r
GCC_VERSION:=8
MODULE_VERSION=$(VERSION)-gcc$(GCC_VERSION)
OPENJDK_VERSION:=1.8.0

