include config.mk
include ../utils.mk

ARCH=x86_64
TARBALL=$(NAME)-$(ARCH)
GITHUB_REPO=https://github.com/rootless-containers/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	chmod ugo+x $(BUILD_PATH)/$(TARBALL)
	cp -R $(BUILD_PATH)/$(TARBALL) $(PREFIX)/$(NAME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
