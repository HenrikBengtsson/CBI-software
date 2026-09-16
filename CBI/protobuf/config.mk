NAME=protobuf
VERSION=36.1

## Abseil is a hard build- AND link-time dependency of protobuf (>= v22), and
## it is NOT bundled in protobuf's release tarball.  Left alone, protobuf's
## CMake 'git clone's it from GitHub in the middle of the configure step, which
## would make the build depend on the network at configure time and on whatever
## the tag pointed at that day.  Instead the pinned version is downloaded as a
## tarball and handed to CMake (see Makefile), and is installed into this same
## PREFIX -- protobuf.pc's 'Requires:' names ~36 absl_* modules, so abseil has
## to travel with protobuf or 'pkg-config --libs protobuf' fails outright.
##
## Keep in sync with 'abseil-cpp-version' in the protobuf tarball's
## cmake/dependencies.cmake when bumping VERSION.
ABSEIL_VERSION=20250512.1

DOWNLOAD_TARGET_FILE=CMakeLists.txt
CONFIG_TARGET_FILE=build/CMakeCache.txt
BUILD_TARGET_FILE=build/protoc
## A header, not bin/protoc: the generic checks try to execute an installed
## target that looks like a binary, and 'protoc' with no arguments prints its
## usage and exits non-zero.
INSTALL_TARGET_FILE=include/google/protobuf/message.h

## This software needs to be built for each Linux distribution separately
LINUX_DISTRO_SPECIFIC=true

CONFIG_MODULES=CBI scl-gcc-toolset cmake
