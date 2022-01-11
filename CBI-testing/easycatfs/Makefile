include config.mk
include ../../CBI/utils.mk

TARBALL=$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/HenrikBengtsson/easycatfs/archive/refs/tags/$(TARBALL); \
	tar xzf $(TARBALL)

## NOTE: For now, we install 'catfs' with 'easycatfs' to avoid
## having a separate module for 'catfs'. This might change later
## /HB 2022-01-11
$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	cargo install --root=$(BUILD_PATH) catfs

$(INSTALL_TARGET):
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH); \
	cp -p README.md NEWS.md $(PREFIX); \
	cp -pR bin/ $(PREFIX)
