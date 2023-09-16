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


available-version:
	@curl https://sourceforge.net/projects/mcmc-jags/files/JAGS/$(VERSION_X).x/Source/ | pandoc --from html --to plain | grep -E "\bJAGS-$(VERSION_X).*[.]tar[.]gz\b" | sed -E 's/(^[|] *JAGS-|[.]tar.*)//g' | head -1
