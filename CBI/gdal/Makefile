include config.mk
include ../utils.mk

## WARNING: GDAL compiles libgdal with -rpath:
## ...
##    -rpath /software/c4/cbi/software/gdal-3.0.0/lib \
##    -no-undefined \
##    -version-info 26:0:0
## If moved to another file location, things might break.
##
## We disable this with option --disable-rpath
##
## /HB 2022-02-04
CONFIG_OPTS=--disable-rpath

GITHUB_REPO=https://github.com/OSGeo/gdal

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://download.osgeo.org/gdal/$(VERSION)/$(TARBALL); \
	tar xvfz $(TARBALL)

## GDAL (>= 3.0.0)
ifeq ($(VERSION_X),3)
    ## GDAL (>= 3.5.0) requires CMake and a modern compiler
    ## Rocky 8 provides a sufficient CMake and compiler

    IS_GE_3_6 := $(shell echo "$(VERSION_X_Y)" | awk -F. '{ if ($$1 > 3 || ($$1 == 3 && $$2 >= 6)) print "yes"; else print "no" }')
    ifeq ($(IS_GE_3_6),yes)
        ## Rocky 8 provides only libarchive 3.3
	ifeq ($(CBI_LINUX),rocky8)
            CONFIG_MODULES:=$(CONFIG_MODULES) CBI libarchive
	endif
        ## Assert
        LIBARCHIVE_VERSION=$(shell module purge; module load $(CONFIG_MODULES); pkg-config --modversion libarchive)
        LIBARCHIVE_VERSION_X_Y_Z := $(shell echo "$(LIBARCHIVE_VERSION)" | sed -E 's/([[:digit:]]+)([.-])([[:digit:]]+)([.-])([[:digit:]]+).*/\1\2\3\4\5/')
        LIBARCHIVE_VERSION_X_Y := $(shell echo "$(LIBARCHIVE_VERSION_X_Y_Z)" | sed -E 's/[.-][^.-]*$$//')
        ifeq ($(LIBARCHIVE_VERSION_X_Y),3.3)
            $(error "GDAL (>= 3.7) requires libarchive (>= 3.5.0), but you got $(LIBARCHIVE_VERSION)")
        else ifeq ($(LIBARCHIVE_VERSION_X_Y),3.4)
            $(error "GDAL (>= 3.7) requires libarchive (>= 3.5.0), but you got $(LIBARCHIVE_VERSION)")
        endif
    endif

    ## Use a modern HDF5, because the 'hdf5r' R package requires hdf5 (>= 1.8.13)
    #CONFIG_MODULES:=$(CONFIG_MODULES) CBI hdf5

    ## WORKAROUND: gdal's configure doesn't find proj/6.0.0 from pkgconfig or LD_LIBRARY_PATH
    PROJ_HOME=$(shell module purge; module load $(CONFIG_MODULES); dirname "$$(dirname "$$(command -v proj)")")
    ## WORKAROUND: gdal's configure doesn't find hdf5 from pkgconfig or LD_LIBRARY_PATH
    HDF5_HOME=$(shell module purge; module load $(CONFIG_MODULES); dirname "$$(dirname "$$(command -v h5stat)")")

    ## Let's use a modern SQLite3 version
    CONFIG_MODULES:=$(CONFIG_MODULES) CBI sqlite
    SQLITE3_HOME=$(shell module purge; module load $(CONFIG_MODULES); dirname "$$(dirname "$$(command -v sqlite3)")")
    CONFIG_OPTS=--disable-rpath --with-hdf5="$(HDF5_HOME)" --with-proj="$(PROJ_HOME)" --with-sqlite3="$(SQLITE3_HOME)"

debug2:
	@echo "PROJ_HOME: $(PROJ_HOME)"
	@echo "SQLITE3_HOME: $(SQLITE3_HOME)"
	@echo "HDF5_HOME: $(HDF5_HOME)"

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(BUILD_PATH)/build"
	cd "$(BUILD_PATH)/build"; \
	module --force purge; \
	module load $(CONFIG_MODULES); \
	cmake .. -DCMAKE_PREFIX_PATH="$$(geos-config --prefix)" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$(PREFIX)" -DSQLITE3_INCLUDE_DIR="$(SQLITE3_HOME)/include"  -DSQLITE3_LIBRARY_RELEASE="$(SQLITE3_HOME)/lib" -DPROJ_INCLUDE_DIR="$(PROJ_HOME)/include" -DPROJ_LIBRARY_RELEASE="$(PROJ_HOME)/lib/libproj.so" -DGDAL_ENABLE_DRIVER_WEBP=OFF


$(BUILD_TARGET): $(CONFIG_TARGET)
	cd "$(BUILD_PATH)/build"; \
	module --force purge; \
	module load $(BUILD_MODULES); \
	cmake --build . --parallel 4

$(INSTALL_TARGET): $(BUILD_TARGET)
	cd "$(BUILD_PATH)/build"; \
        cmake --build . --target install
else
$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH); \
	make --quiet install-man; \
	make --quiet install
	make --quiet post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
endif

BUILD_MODULES=$(CONFIG_MODULES)

