NAME=poppler
VERSION=26.09.0

DOWNLOAD_TARGET_FILE=CMakeLists.txt
CONFIG_TARGET_FILE=build/CMakeCache.txt
BUILD_TARGET_FILE=build/cpp/libpoppler-cpp.so
INSTALL_TARGET_FILE=bin/pdftotext

## This software needs to be built for each Linux distribution separately
LINUX_DISTRO_SPECIFIC=true

## Poppler (>= 26.09.0) requires CMake (>= 3.28) and a C++23 compiler,
## i.e. neither the Rocky/RHEL 9 system CMake nor its system GCC will do
CONFIG_MODULES=CBI scl-gcc-toolset cmake
