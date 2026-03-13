include config.mk
include ../utils.mk

ARCH=linux_amd64
TARBALL=$(NAME)_$(VERSION)_$(ARCH).tar.gz
GITHUB_REPO=https://github.com/anchore/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar -C "$(BUILD_PATH)" -xzf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -R $(BUILD_PATH) $(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
