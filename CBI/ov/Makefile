include config.mk
include ../utils.mk

ARCH=linux_amd64
TARBALL=$(NAME)_$(VERSION)_$(ARCH).zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/noborus/ov/releases/download/v$(VERSION)/$(TARBALL); \
	unzip $(TARBALL) -d $(BUILD_PATH)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -R "$(<D)" "$(PREFIX)/.."
