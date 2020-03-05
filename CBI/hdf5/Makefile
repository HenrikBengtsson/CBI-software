include config.mk
include ../utils.mk

#DOWNLOAD_URL=https://hdf-wordpress-1.s3.amazonaws.com/wp-content/uploads/manual/HDF5/HDF5_1_10_6/source
DOWNLOAD_URL=https://support.hdfgroup.org/ftp/HDF5/releases/$(NAME)-$(VERSION_X_Y)/$(NAME)-$(VERSION)/src


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(DOWNLOAD_URL)/$(TARBALL); \
	tar xvfz $(TARBALL)

