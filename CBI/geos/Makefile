include config.mk
include ../utils.mk


TARBALL=$(NAME)-$(VERSION).tar.bz2

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
