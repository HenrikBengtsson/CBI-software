NAME=proj

## PROJ 9.0.0 was released on 2022-03-01
VERSION=9.7.0

DOWNLOAD_TARGET_FILE=ChangeLog

include ../version.mk
ifeq ($(VERSION_X),9)
CONFIG_TARGET_FILE=build/Makefile
BUILD_TARGET_FILE=build/bin/proj
else
CONFIG_TARGET_FILE=config.log
BUILD_TARGET_FILE=libtool
endif

INSTALL_TARGET_FILE=bin/proj
