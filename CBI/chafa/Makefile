include config.mk
include ../utils.mk

ARCH=x86_64-linux-gnu
VERSION2=$(VERSION)$(PATCH_VERSION)
TARBALL=$(NAME)-$(VERSION2)-$(ARCH).tar.gz
GITHUB_REPO=https://github.com/hpjansson/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://hpjansson.org/chafa/releases/static/$(TARBALL); \
	tar -xzf $(TARBALL); \
	mv $(NAME)-$(VERSION2)-$(ARCH) $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
