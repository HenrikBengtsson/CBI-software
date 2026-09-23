include config.mk
include ../utils.mk

ARCH=linux_amd64
TARBALL=$(NAME)_$(ARCH).tar.gz
GITHUB_REPO=https://github.com/shenwei356/seqkit

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar xf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/bin"
	cd "$(BUILD_PATH)"; \
	cp -p "$(NAME)" "$(PREFIX)/bin/"
