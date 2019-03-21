#' Example:
#' make VERSION=2.2.0

include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O http://hisham.hm/htop/releases/$(VERSION)/$(TARBALL); \
	tar xvfz $(TARBALL)
