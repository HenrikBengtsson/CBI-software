include config.mk
include ../utils.mk

ARCH=linux-x64
TARBALL=$(NAME)-$(VERSION)_$(ARCH)_bin.tar.gz
DOWNLOAD_HASH=b1e0dfa218384cb9959bdcb897162d4e

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O https://download.java.net/java/GA/jdk$(VERSION)/$(DOWNLOAD_HASH)/10/GPL/$(TARBALL); \
	tar -xzf $(TARBALL)
	[[ -d "$(BUILD_HOME)/jdk-$(VERSION)" ]] || { echo "UNEXPECTED VERSION: jdk-$(VERSION)/ does not exits"; ls -l $(BUILD_HOME); exit 1; }
	mv "$(BUILD_HOME)/jdk-$(VERSION)" "$(BUILD_PATH)"


$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
