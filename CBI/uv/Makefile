include config.mk
include ../utils.mk

ARCH=x86_64-unknown-linux-gnu
TARBALL=$(NAME)-$(ARCH).tar.gz

GITHUB_REPO=https://github.com/astral-sh/uv

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_HOME); \
	curl -L -O https://releases.astral.sh/github/uv/releases/download/$(VERSION)/$(TARBALL); \
        tar xf $(TARBALL) --strip-components=1 -C $(BUILD_PATH)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -pR "$(BUILD_PATH)" "$(PREFIX)/.."
	ls -al "$(PREFIX)"

