include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).tar.xz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://gmplib.org/download/gmp/$(TARBALL); \
	tar xf $(TARBALL)
