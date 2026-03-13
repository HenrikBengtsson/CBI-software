include config.mk
include ../utils.mk

ARCH=linux-amd64
TARBALL=$(NAME)-$(VERSION)-$(ARCH).tar.gz
GITHUB_REPO=https://github.com/coder/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar zxf $(TARBALL); \
	mv "$(NAME)-$(VERSION)-$(ARCH)" "$(NAME)-$(VERSION)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -p -R "$(BUILD_PATH)" "$(PREFIX)"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|-|\/)//'

#https://github.com/coder/code-server/releases/download/v4.95.3/code-server-4.95.3-linux-amd64.tar.gz
