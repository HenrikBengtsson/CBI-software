include config.mk
include ../utils.mk


TARBALL=$(NAME)-linux-portable.zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O https://github.com/ahrm/sioyek/releases/download/v$(VERSION)/$(TARBALL); \
	unzip "$(TARBALL)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp "$<" $(PREFIX)/
	cp -R "$<.config" $(PREFIX)/
	ln -s "$<" $(PREFIX)/sioyek
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
