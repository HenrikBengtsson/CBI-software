NAME=gdal

VERSION=3.13.2

## GDAL < 3.6.0
#VERSION=2.4.4
DOWNLOAD_FILE=configure
BUILD_TARGET_FILE=apps/gdalinfo

## GDAL >= 3.6.0
DOWNLOAD_TARGET_FILE=gdal.cmake
CONFIG_TARGET_FILE=build/Makefile
BUILD_TARGET_FILE=build/apps/gdalinfo

## This software needs to be built for each Linux distribution separately
LINUX_DISTRO_SPECIFIC=true

## All versions
INSTALL_TARGET_FILE=bin/gdalinfo


CONFIG_MODULES=CBI scl-gcc-toolset

## GDAL (>= 3.0.0) requires PROJ (>= 6.0.0)
CONFIG_MODULES:=$(CONFIG_MODULES) CBI proj

## Build GDAL with GEOS support
CONFIG_MODULES:=$(CONFIG_MODULES) CBI geos
