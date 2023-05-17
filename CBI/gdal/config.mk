NAME=gdal

## GDAL < 3.6.0
VERSION=2.4.4
DOWNLOAD_FILE=configure
BUILD_TARGET_FILE=apps/gdalinfo

## GDAL >= 3.6.0
VERSION=3.6.4
DOWNLOAD_TARGET_FILE=gdal.cmake
CONFIG_TARGET_FILE=build/Makefile
BUILD_TARGET_FILE=build/apps/gdalinfo

## All versions
INSTALL_TARGET_FILE=bin/gdalinfo




