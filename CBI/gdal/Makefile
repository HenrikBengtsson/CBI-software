include config.mk
include ../utils.mk

## WARNING: GDAL compiles libgdal with -rpath:
## ...
##    -rpath /software/c4/cbi/software/gdal-3.0.0/lib \
##    -no-undefined \
##    -version-info 26:0:0
## If moved to another file location, things might break.
##
## Ah, there an option --disable-rpath
##
## /HB 2022-02-04


## GDAL (>= 3.0.0) requires PROJ (>= 6.0.0)
ifneq ($(VERSION_X),2)
    ifeq ($(VERSION_X_Y),3.6)
        $(error Not yet supported: $NAME >= 3.6.0 requires CMake)
    endif

    CONFIG_MODULES=CBI proj/8.2.1 hdf5 sqlite

    ## WORKAROUND: gdal's configure doesn't find proj/6.0.0 from pkgconfig or LD_LIBRARY_PATH
    PROJ_HOME=$(shell module load $(CONFIG_MODULES); dirname "$$(dirname "$$(command -v proj)")")
    ## WORKAROUND: gdal's configure doesn't find hdf5 from pkgconfig or LD_LIBRARY_PATH
    HDF5_HOME=$(shell module load $(CONFIG_MODULES); dirname "$$(dirname "$$(command -v h5stat)")")
    SQLITE3_HOME=$(shell module load $(CONFIG_MODULES); dirname "$$(dirname "$$(command -v sqlite3)")")
    CONFIG_OPTS=--disable-rpath --with-hdf5="$(HDF5_HOME)" --with-proj="$(PROJ_HOME)" --with-sqlite3="$(SQLITE3_HOME)"
endif
BUILD_MODULES=$(CONFIG_MODULES)


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://download.osgeo.org/gdal/$(VERSION)/$(TARBALL); \
	tar xvfz $(TARBALL)



