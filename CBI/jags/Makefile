include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://downloads.sourceforge.net/project/mcmc-jags/JAGS/$(VERSION_X).x/Source/$(TARBALL); \
	tar xvfz $(TARBALL)
