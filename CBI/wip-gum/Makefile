include config.mk
include ../utils.mk

ARCH=Linux_x86_64
TARBALL=$(NAME)_$(VERSION)_$(ARCH).tar.gz
GITHUB_OWNER=charmbracelet
GITHUB_REPO=$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/$(GITHUB_OWNER)/$(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar xf "$(TARBALL)"; \
	mv "$(NAME)_$(VERSION)_$(ARCH)" "$(NAME)-$(VERSION)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -p -R "$(BUILD_PATH)" "$(PREFIX)/.."
	mkdir "$(PREFIX)/man"
	mv "$(PREFIX)/manpages" "$(PREFIX)/man/man1"
	gunzip "$(PREFIX)/man/man1/gum.1.gz"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	curl --head --silent "https://github.com/$(GITHUB_OWNER)/$(GITHUB_REPO)/releases/latest" | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'

