include config.mk
include ../utils.mk


TARBALL=$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/junegunn/$(NAME)/archive/$(TARBALL); \
	tar zxf $(TARBALL)

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	./install --bin

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
