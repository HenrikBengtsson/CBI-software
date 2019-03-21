#' Example:
#' make VERSION=5.127

include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
TARBALL=$(NAME)_$(VERSION)$(BUILD_SUFFIX).orig.tar.gz

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl --insecure -L -O https://launchpad.net/byobu/trunk/$(VERSION)/+download/$(TARBALL); \
	tar xvfz $(TARBALL)

test_software: $(BUILD_TARGET)
	cd $(BUILD_PATH); \
	make check
