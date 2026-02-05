NAME=htop
VERSION=3.4.1

## This software needs to be built for each Linux distribution separately
## (unless 'ncurses-compat-libs' is installed)
LINUX_DISTRO_SPECIFIC=true

BUILD_TARGET_FILE=htop
INSTALL_TARGET_FILE=bin/htop

CONFIG_MODULES=autotools CBI scl-gcc-toolset
