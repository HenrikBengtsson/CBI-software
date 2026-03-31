NAME=redis

VERSION=7.4.8

## redis (>= 8.0) requires jemalloc.h
#VERSION=8.6.2

DOWNLOAD_TARGET_FILE=Makefile
CONFIG=false
BUILD_TARGET_FILE=src/redis-cli
INSTALL_TARGET_FILE=bin/redis-cli
