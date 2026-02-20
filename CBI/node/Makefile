include config.mk
include ../utils.mk

ARCH=linux-x64
FULLNAME=$(NAME)-v$(VERSION)-$(ARCH)
TARBALL=$(FULLNAME).tar.gz

GITHUB_REPO=https://github.com/nodejs/$(NAME)


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O "https://nodejs.org/dist/v$(VERSION)/$(TARBALL)"; \
	tar -xzf $(TARBALL); \
	mv "$(FULLNAME)" "$(NAME)-$(VERSION)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -R "$(BUILD_PATH)" "$(PREFIX)/.."
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"


available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
