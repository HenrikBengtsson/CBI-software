NAME=bcftools
VERSION=1.22
BUILD_TARGET_FILE=.patched/done
INSTALL_TARGET_FILE=bin/$(NAME)

CONFIG_MODULES=CBI scl-gcc-toolset
DEPENDS_ON=bzip2-devel libcurl-devel
