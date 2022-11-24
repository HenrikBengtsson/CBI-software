include config.mk
include ../utils.mk

## PROJ (>= 6.3.0) requires sqlite3 (>= 3.11)
ifeq ($(VERSION_X_Y),6.3)
    CONFIG_MODULES=CBI sqlite
else ifeq ($(VERSION_X),7)
    CONFIG_MODULES=CBI sqlite
else ifeq ($(VERSION_X),8)
    CONFIG_MODULES=CBI sqlite
endif


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
