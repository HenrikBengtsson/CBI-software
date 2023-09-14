include config.mk
include ../utils.mk

TARBALL=jdk-$(VERSION_X)_linux-x64_bin.tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O https://download.oracle.com/java/$(VERSION_X)/latest/$(TARBALL); \
	tar -xzf $(TARBALL)
	[[ -d "$(BUILD_HOME)/jdk-$(VERSION)" ]] || { echo "UNEXPECTED VERSION: jdk-$(VERSION)/ does not exits"; ls -l $(BUILD_HOME); exit 1; }
	mv "$(BUILD_HOME)/jdk-$(VERSION)" "$(BUILD_PATH)"


$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
