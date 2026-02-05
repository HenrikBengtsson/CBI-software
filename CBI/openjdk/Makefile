include config.mk
include ../utils.mk

ARCH=linux-x64
TARBALL=$(NAME)-$(VERSION)_$(ARCH)_bin.tar.gz

ifeq ($(VERSION),17.0.0.1+2)
  DOWNLOAD_URL=https://download.java.net/openjdk/jdk$(VERSION_X_Y_Z_ZZ)/ri/openjdk-$(VERSION)_$(ARCH)_bin.tar.gz
else ifeq ($(VERSION_X),25)
  DOWNLOAD_HASH=b1e0dfa218384cb9959bdcb897162d4e
  DOWNLOAD_URL=https://download.java.net/java/GA/jdk$(VERSION)/$(DOWNLOAD_HASH)/10/GPL/$(TARBALL)
endif

ifeq ($(DOWNLOAD_URL),)
  $(error DOWNLOAD_URL is empty. Check if VERSION is set correctly: $(VERSION))
endif

#BUILD_PATH=$(BUILD_HOME)/$(NAME)-$(VERSION_X_Y_Z)
#PREFIX=$(SOFTWARE_HOME)/$(NAME)-$(VERSION_X_Y_Z)
#INSTALL_TARGET=$(PREFIX)/$(INSTALL_TARGET_FILE)
#include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O "$(DOWNLOAD_URL)"; \
	tar -xzf $(TARBALL)
	[[ -d "$(BUILD_HOME)/jdk-$(VERSION_X_Y_Z_ZZ)" ]] || { echo "UNEXPECTED VERSION: jdk-$(VERSION_X_Y_Z_ZZ)/ does not exits"; ls -l $(BUILD_HOME); exit 1; }
	mv "$(BUILD_HOME)/jdk-$(VERSION_X_Y_Z_ZZ)" "$(BUILD_PATH)"


$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

install: $(INSTALL_TARGET)
