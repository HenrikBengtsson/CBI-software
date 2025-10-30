include config.mk
include ../utils.mk

#DOWNLOAD_URL=https://hdf-wordpress-1.s3.amazonaws.com/wp-content/uploads/manual/HDF5/HDF5_1_10_6/source
DOWNLOAD_URL=https://support.hdfgroup.org/ftp/HDF5/releases/$(NAME)-$(VERSION_X_Y)/$(NAME)-$(VERSION)/src

GITHUB_REPO=https://github.com/HDFGroup/hdf5

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
