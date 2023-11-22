include config.mk
include ../utils.mk


TARBALL=$(NAME)-$(VERSION).tar.xz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O https://github.com/Rajaram-Regupathy/libtypec/releases/download/$(NAME)-$(VERSION)/$(TARBALL); \
	tar xf "$(TARBALL)"; \
	rm "$(TARBALL)"
	ls -l "$(BUILD_PATH)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)/..
	cp -R "$(BUILD_PATH)" $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
