#' Example:
#' make VERSION=2.2.0

include config.mk

TARBALL=$(NAME)-$(VERSION).tar.bz2

GITHUB_REPO=https://github.com/samtools/samtools

URL=$(GITHUB_REPO)/releases/download/$(VERSION)/$(TARBALL)
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
	mkdir -p $(PREFIX)/share/man/man1
	cd $(BUILD_PATH); \
	cp -R -- * "$(PREFIX)"
	ln -s $(PREFIX)/samtools.1 $(PREFIX)/share/man/man1
	cd $(PREFIX); \
	rm -- *.o bcftools/*.o misc/*.o
endif


available-version:
	@curl --silent https://github.com/samtools/htslib/tags | pandoc --from=html --to=plain | grep -E "^[[:digit:]]+[.][[:digit:]]+" | head -1


