NAME=samtools
VERSION=1.18

## This software needs to be built for each Linux distribution separately
LINUX_DISTRO_SPECIFIC=true

BUILD_TARGET_FILE=$(NAME)
INSTALL_TARGET_FILE=bin/$(NAME)
