include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/extrawurst/gitui
TARBALL=$(NAME)-linux-x86_64.tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p "$(BUILD_PATH)"
	cd "$(BUILD_PATH)"; \
	curl -L -O "$(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL)"; \
	tar zxf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	cp -p $(BUILD_PATH)/gitui $(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|-|\/)//'
