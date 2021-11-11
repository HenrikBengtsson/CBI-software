include config.mk
include ../utils.mk

NAME2=libSBML
TARBALL=$(NAME2)-$(VERSION)-core-src.tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -o $(TARBALL) https://sourceforge.net/projects/sbml/files/libsbml/$(VERSION)/stable/$(TARBALL)/download; \
	tar zxf $(TARBALL)
