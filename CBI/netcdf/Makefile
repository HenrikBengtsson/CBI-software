include config.mk
include ../utils.mk

TARBALL=$(NAME)-c-$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://downloads.unidata.ucar.edu/netcdf-c/$(VERSION)/$(TARBALL); \
	tar xvfz $(TARBALL); \
	rm -rf $(NAME)-$(VERSION); \
	mv $(NAME)-c-$(VERSION) $(NAME)-$(VERSION)

available-version:
	@curl -s https://api.github.com/repos/Unidata/netcdf-c/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([0-9.]+).*/\1/'
