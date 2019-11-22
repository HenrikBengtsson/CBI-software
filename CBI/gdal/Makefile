include config.mk
include ../utils.mk

#	curl -L -O https://github.com/OSGeo/gdal/releases/download/v$(VERSION)/$(TARBALL); \

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://download.osgeo.org/gdal/$(VERSION)/$(TARBALL); \
	tar xvfz $(TARBALL)

