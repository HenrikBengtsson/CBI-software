NAME=fftw3
VERSION=3.3.10
DOWNLOAD_FILE=configure
BUILD_TARGET_FILE=tests/bench
INSTALL_TARGET_FILE=lib/libfftw3.so

CONFIG_OPTS=--enable-shared --enable-threads --enable-openmp LDFLAGS=""
