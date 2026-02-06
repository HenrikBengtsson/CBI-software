NAME=mc
VERSION=4.8.33

CONFIG_OPTS=--with-screen=ncurses
BUILD_TARGET_FILE=bin/mc
BUILD_OPTS=-j 4
## mc (>= 4.8.28) requires a C99-compliant compiler
INSTALL_TARGET_FILE=bin/mc

CONFIG_MODULES=CBI scl-gcc-toolset

