include config.mk
include ../version.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/stan-dev/cmdstan/releases/download/v$(VERSION)/$(TARBALL); \
	tar xfz $(TARBALL)

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	make build -j4

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -R "$(BUILD_PATH)" "$(PREFIX)/.."
	make post_install
