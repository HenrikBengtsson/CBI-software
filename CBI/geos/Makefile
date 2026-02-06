include config.mk
include ../utils.mk

## IMPORTANT:
## geos (>= 3.8.0) requires a modern compiler toolchain, e.g.
##
##  - gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
##
## is too old and results in a 'make check' error on:
##
## *** Error in `*/tests/unit/.libs/lt-geos_unit': free(): invalid pointer: 0x00007ffc0a99d930 ***
##
## This was observed for geos 3.8.1 and geos 3.9.1
##
## module load scl-devtoolset/8 provides:
##
##  - gcc (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3)
##
## which seems to suffice.

## Use the most modern version of GCC installed
CONFIG_MODULES=CBI scl-gcc-toolset cmake

## GEOS (>= 3.10.0) requires CMake (>= 3.13)
ifeq ($(VERSION_X_Y),3.9)
  CONFIG_MODULES=CBI scl-gcc-toolset
endif

TARBALL=$(NAME)-$(VERSION).tar.bz2
GITHUB_REPO=https://github.com/libgeos/geos

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O http://download.osgeo.org/geos/$(TARBALL); \
	tar vxjf $(TARBALL)

$(BUILD_PATH)/check.log:
	cd $(BUILD_PATH); \
	module --force purge; \
	module load $(BUILD_MODULES); \
	module list; \
	make check &> check.log

post_build: $(BUILD_PATH)/check.log

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
