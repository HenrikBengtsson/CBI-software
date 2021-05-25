NAME=R
VERSION:=4.0.5
URL_DOWNLOAD=https://cran.r-project.org/
URL=https://cran.r-project.org/src/base/R-4/
CONFIG_OPTS=--enable-memory-profiling --enable-R-shlib --without-recommended-packages
BUILD_TARGET_FILE=bin/exec/R
BUILD_OPTS=-j 4
INSTALL_TARGET_FILE=bin/R
MODULE_NAME=r
CUSTOM_GCC=true

