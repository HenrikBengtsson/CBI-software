include config.mk
include ../utils.mk

#DOWNLOAD_URL=https://hdf-wordpress-1.s3.amazonaws.com/wp-content/uploads/manual/HDF5/HDF5_1_10_6/source
#DOWNLOAD_URL=https://support.hdfgroup.org/ftp/HDF5/releases/$(NAME)-$(VERSION_X_Y)/$(NAME)-$(VERSION)/src

GITHUB_REPO=https://github.com/HDFGroup/hdf5
DOWNLOAD_URL=$(GITHUB_REPO)/releases/download/$(NAME)_$(VERSION_X_Y)

# From the 'make build' output:
#
# Libraries have been installed in:
#    /software/c4/cbi/software/hdf5-1.14.6/lib
# 
# If you ever happen to want to link against installed libraries
# in a given directory, LIBDIR, you must either use libtool, and
# specify the full pathname of the library, or use the '-LLIBDIR'
# flag during linking and do at least one of the following:
#    - add LIBDIR to the 'LD_LIBRARY_PATH' environment variable
#      during execution
#    - add LIBDIR to the 'LD_RUN_PATH' environment variable
#      during linking
#    - use the '-Wl,-rpath -Wl,LIBDIR' linker flag
#    - have your system administrator add LIBDIR to '/etc/ld.so.conf'

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(DOWNLOAD_URL)/$(TARBALL); \
	tar xvfz $(TARBALL)

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//' | sed -E 's/^hdf5_//'
