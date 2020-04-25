NAME=R
VERSION:=4.0.0
URL=https://cran.r-project.org/src/base/R-4/
CONFIG_OPTS=--enable-memory-profiling --enable-R-shlib
BUILD_TARGET_FILE=bin/exec/R
BUILD_OPTS=-j 4
INSTALL_TARGET_FILE=bin/R
MODULE_NAME=r
