include config.mk
include ../utils.mk

TARBALL=udunits-$(VERSION).tar.gz
CONFIG_MODULES=libexpat

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://downloads.unidata.ucar.edu/udunits/$(VERSION)/$(TARBALL); \
CONFIG_MODULES=libexpat
	tar xf $(TARBALL); \
CONFIG_MODULES=libexpat
	mv udunits-$(VERSION) $(NAME)-$(VERSION)
