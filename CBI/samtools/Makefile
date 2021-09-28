#' Example:
#' make VERSION=2.2.0

include config.mk

TARBALL=$(NAME)-$(VERSION).tar.bz2

URL=https://github.com/samtools/$(NAME)/releases/download/$(VERSION)/$(TARBALL)
VERSION_X := $(shell echo "$(VERSION)" | sed -E 's/[.].*//')
ifeq ($(VERSION_X),0)
  VERSION_NO_SUFFIX := $(shell echo "$(VERSION)" | sed -E 's/[a-z]$$//')
  URL=https://sourceforge.net/projects/samtools/files/samtools/$(VERSION_NO_SUFFIX)/$(TARBALL)/download
  DOWNLOAD_TARGET_FILE=Makefile
  CONFIG=false
endif

include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -o ${TARBALL} $(URL); \
	tar jxf $(TARBALL)

ifeq ($(VERSION_X),0)
$(INSTALL_TARGET):
	mkdir -p "$(PREFIX)/bin"
	cd $(BUILD_PATH); \
	cp samtools "$(PREFIX)/bin"
endif
