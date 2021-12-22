include config.mk
include ../utils.mk


TARBALL=$(NAME)_$(VERSION)_$(ARCH).bz2

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O https://github.com/restic/restic/releases/download/v$(VERSION)/$(TARBALL); \
	bunzip2 $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cd $(PREFIX); \
	cp -R $(BUILD_PATH) ..; \
	chmod ugo+x $(DOWNLOAD_TARGET_FILE); \
	ln -s $(DOWNLOAD_TARGET_FILE) $(NAME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
