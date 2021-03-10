NAME=proj
VERSION=4.9.3

URL_DOWNLOAD=https://proj.org/download.html
DOWNLOAD_FILE=configure
BUILD_TARGET_FILE=libtool
INSTALL_TARGET_FILE=bin/proj

## PROJ 7.2.1 requires sqlite3 (>= 3.11)
CONFIG_MODULES=CBI sqlite

## PROJ 4.9.3 requires sqlite3 (>= 3.??)
CONFIG_MODULES=
