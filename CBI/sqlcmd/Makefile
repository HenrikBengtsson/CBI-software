include config.mk
include ../utils.mk

ARCH=linux-amd64
TARBALL=$(NAME)-$(ARCH).tar.bz2

GITHUB_REPO=https://github.com/microsoft/go-sqlcmd

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar -xf $(TARBALL) -C "$(BUILD_PATH)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -p -R "$(BUILD_PATH)" "$(PREFIX)/.."
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E -e 's/.*(v|\/)//' -e 's/[[:space:]]+//g'

