include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://download.osgeo.org/proj/$(TARBALL); \
	tar xvfz $(TARBALL)

$(BUILD_PATH)/check.log:
	cd $(BUILD_PATH); \
	module --force purge; \
	module load $(BUILD_MODULES); \
	module list; \
	make check &> check.log

post_build: $(BUILD_PATH)/check.log
