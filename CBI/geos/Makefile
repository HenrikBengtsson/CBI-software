include config.mk
include ../utils.mk

## GEOS (>= 3.10.0) requires CMake (>= 3.13)
ifeq ($(VERSION_X_Y),3.10)
  CONFIG_MODULES=CBI cmake
else ifeq ($(VERSION_X_Y),3.11)
  CONFIG_MODULES=CBI cmake
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
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -E "^location:" | sed -E 's/.*(v|\/)//'
