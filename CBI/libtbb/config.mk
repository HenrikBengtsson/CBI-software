NAME=libtbb
VERSION=2023.1.0

DOWNLOAD_TARGET_FILE=CMakeLists.txt
CONFIG_TARGET_FILE=build/CMakeCache.txt
BUILD_TARGET_FILE=build/install_manifest.txt
INSTALL_TARGET_FILE=include/tbb/tbb.h

## This software needs to be built for each Linux distribution separately
LINUX_DISTRO_SPECIFIC=true

CONFIG_MODULES=CBI scl-gcc-toolset cmake
BUILD_MODULES=$(CONFIG_MODULES)
