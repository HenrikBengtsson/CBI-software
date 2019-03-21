include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/qtop/${NAME}/archive/v${VERSION}.tar.gz; \
	tar xzf v${VERSION}.tar.gz

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(SOFTWARE_HOME)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install_software
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
