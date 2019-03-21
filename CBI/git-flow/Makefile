include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
TARBALL=$(VERSION).tar.gz

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/petervanderdoes/gitflow-avh/archive/$(TARBALL); \
	tar xvfz $(TARBALL)

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	cp Makefile Makefile.tmp; \
	sed 's|^prefix=/usr/local|prefix = $(PREFIX)|' Makefile.tmp > Makefile; \
	mv Makefile.tmp $@

$(BUILD_TARGET): $(CONFIG_TARGET)
	touch $@
