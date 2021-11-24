include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH)
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/dmtcp/dmtcp/releases/download/$(VERSION)/$(TARBALL); \
	tar zxf $(TARBALL)
