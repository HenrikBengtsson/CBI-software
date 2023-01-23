include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
TARBALL=$(VERSION).tar.gz
GITHUB_REPO=https://github.com/petervanderdoes/gitflow-avh

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/archive/$(TARBALL); \
	tar xvfz $(TARBALL)

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	cp Makefile Makefile.tmp; \
	sed 's|^prefix=/usr/local|prefix = $(PREFIX)|' Makefile.tmp > Makefile; \
	mv Makefile.tmp $@

$(BUILD_TARGET): $(CONFIG_TARGET)
	touch $@

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -E "^location:" | sed -E 's/.*(v|\/)//'
