include config.mk
include ../utils.mk

ARCH=linux-x86_64
TARBALL=$(NAME)-$(ARCH)-$(VERSION)-$(COMMIT).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH)
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/TileDB-Inc/TileDB/releases/download/$(VERSION)/$(TARBALL); \
	cd $(BUILD_PATH); tar zxf ../$(TARBALL)


$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -pR $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
