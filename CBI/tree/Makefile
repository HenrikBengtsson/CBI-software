include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).tgz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O http://mama.indstate.edu/users/ice/tree/src/$(TARBALL); \
	tar xvfz $(TARBALL)

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	cp Makefile Makefile.org; \
	sed 's|^prefix = /usr|prefix = $(PREFIX)|' Makefile.org > Makefile.tmp; \
	sed 's|^PREFIX=/usr/local|PREFIX=$(PREFIX)|' Makefile.tmp > Makefile; \
	rm Makefile.tmp
	touch $@
