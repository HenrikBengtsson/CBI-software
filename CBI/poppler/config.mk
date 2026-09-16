NAME=poppler

## This is the most recent version that builds out-of-the-box on Rocky 9
VERSION=24.04.0

DOWNLOAD_TARGET_FILE=CMakeLists.txt
CONFIG_TARGET_FILE=build/CMakeCache.txt
BUILD_TARGET_FILE=build/cpp/libpoppler-cpp.so
INSTALL_TARGET_FILE=bin/pdftotext

LINUX_DISTRO_SPECIFIC=true

CONFIG_MODULES=CBI scl-gcc-toolset cmake
