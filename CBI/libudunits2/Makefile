include config.mk
include ../utils.mk

TARBALL=udunits-$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://downloads.unidata.ucar.edu/udunits/$(VERSION)/$(TARBALL); \
	tar xf $(TARBALL); \
	mv udunits-$(VERSION) $(NAME)-$(VERSION)
