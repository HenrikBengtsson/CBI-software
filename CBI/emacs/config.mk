NAME=emacs
VERSION=30.1

## This software needs to be built for each Linux distribution separately
LINUX_DISTRO_SPECIFIC=true

CONFIG_OPTS=--with-xpm=no --with-gif=no --with-gnutls=no
BUILD_TARGET_FILE=src/emacs
INSTALL_TARGET_FILE=bin/emacs
