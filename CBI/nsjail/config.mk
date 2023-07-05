## nsjail requires CGroups v2, which is _not_ supported by CentOS 7

NAME=nsjail
VERSION=3.3
DOWNLOAD_TARGET_FILE=Makefile
CONFIG_TARGET_FILE=Makefile
BUILD_TARGET_FILE=nsjail
INSTALL_TARGET_FILE=nsjail

BUILD_MODULES=CBI scl-devtoolset/10
