NAME=postgresql
VERSION=18.6
DOWNLOAD_FILE=configure
BUILD_TARGET_FILE=src/interfaces/libpq/libpq.a
INSTALL_TARGET_FILE=lib/libpq.a

# We use 17.11 which is a current stable version of PostgreSQL 17 series
# No extra build opts are strictly necessary, default prefix is handled by utils.mk
BUILD_OPTS = MAKEFLAGS= MAKELEVEL= MFLAGS=
INSTALL_OPTS = MAKEFLAGS= MAKELEVEL= MFLAGS=
CONFIG_OPTS = --disable-rpath
