include config.mk
include ../utils.mk

ARCH=x86_64-unknown-linux-musl
TARBALL=$(NAME)-$(VERSION)-$(ARCH).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/BurntSushi/ripgrep/releases/download/$(VERSION)/$(TARBALL); \
	tar -xzf $(TARBALL); \
	mv $(NAME)-$(VERSION)-$(ARCH) $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
