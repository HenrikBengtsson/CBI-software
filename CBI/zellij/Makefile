include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
ARCH=x86_64-unknown-linux-musl
TARBALL=$(NAME)-$(ARCH).tar.gz

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O https://github.com/zellij-org/zellij/releases/download/v$(VERSION)/$(TARBALL); \
	tar xvfz $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	cp "$<" "$(PREFIX)"
