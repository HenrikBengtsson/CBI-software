NAME=proj

## proj (>= 9) don't use configure
VERSION=9.7.0
include ../version.mk

DOWNLOAD_TARGET_FILE=ChangeLog

ifeq ($(VERSION_X),9)
CONFIG_TARGET_FILE=build/Makefile
BUILD_TARGET_FILE=build/bin/proj
else
CONFIG_TARGET_FILE=libtool
BUILD_TARGET_FILE=libtool
endif

INSTALL_TARGET_FILE=bin/proj
