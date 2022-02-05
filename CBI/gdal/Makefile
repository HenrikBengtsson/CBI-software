include config.mk
include ../utils.mk

## GDAL (>= 3.0.0) requires PROJ (>= 6.0.0)
ifneq ($(VERSION_X),2)
    CONFIG_MODULES=CBI proj/6.0.0

    ## WORKAROUND: gdal's configure doesn't find proj/6.0.0 from pkgconfig or LD_LIBRARY_PATH
    PROJ_HOME=$(shell module load $(CONFIG_MODULES); dirname "$$(dirname "$$(command -v proj)")")
    CONFIG_OPTS=--with-proj="$(PROJ_HOME)"
endif


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://download.osgeo.org/gdal/$(VERSION)/$(TARBALL); \
	tar xvfz $(TARBALL)



