include config.mk
include ../utils.mk


ARCH=linux-glibc-x86_64
TARBALL=$(NAME)-$(VERSION)-$(ARCH).tar.gz
GITHUB_REPOSITORY=https://github.com/pkolaczk/fclones

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH)
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPOSITORY)/releases/download/v$(VERSION)/$(TARBALL); \
	cd $(BUILD_PATH); \
	tar xf "../$(TARBALL)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	cp -R "$(BUILD_PATH)/usr/"* "$(PREFIX)"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
