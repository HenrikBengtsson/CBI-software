include config.mk
include ../utils.mk

## PROJ (>= 6.3.0) requires sqlite3 (>= 3.11)
ifneq ($(VERSION_X_Y),6.3)
    CONFIG_MODULES=CBI sqlite
    ## TODO: This is not sufficent. Figure out why configure still gives:
    ##   Requested 'sqlite3 >= 3.11' but version of SQLite is 3.7.17
    ## despite above module gives sqlite3 v3.32.3. /HB 2022-02-04
    $(error "STILL NOT SUPPORTED: Cannot install proj $(VERSION)")
endif

FOO=$(error "STILL NOT SUPPORTED: Cannot install proj $(VERSION)")


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
