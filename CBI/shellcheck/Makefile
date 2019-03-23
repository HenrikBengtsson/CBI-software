include config.mk
include ../utils.mk

TARBALL=$(NAME)-v$(VERSION).linux.x86_64.tar.xz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O https://storage.googleapis.com/shellcheck/$(TARBALL); \
	tar Jxf $(TARBALL); \
	mv $(NAME)-v$(VERSION) $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install_software
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
