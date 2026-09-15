include config.mk

TARBALL=libsodium-$(VERSION).tar.gz
BUILD_NAME=libsodium-$(VERSION)

URL=https://download.libsodium.org/libsodium/releases/$(TARBALL)

include ../utils.mk

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(URL); \
	tar xvfz $(TARBALL)

available-version:
	@curl -sI https://download.libsodium.org/libsodium/releases/LATEST.tar.gz | grep -i Location | sed -n 's/.*libsodium-\(.*\)\.tar\.gz.*/\1/p'
