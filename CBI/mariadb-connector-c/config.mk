NAME=mariadb-connector-c
VERSION=3.4.9

## Upstream ships '<name>-<version>-src.tar.gz'
BUILD_SUFFIX=-src

DOWNLOAD_TARGET_FILE=CMakeLists.txt
CONFIG_TARGET_FILE=build/CMakeCache.txt
BUILD_TARGET_FILE=build/libmariadb/libmariadb.so.3
INSTALL_TARGET_FILE=bin/mariadb_config
RECENT_ONLY=true

LINUX_DISTRO_SPECIFIC=true

CONFIG_MODULES=CBI cmake
