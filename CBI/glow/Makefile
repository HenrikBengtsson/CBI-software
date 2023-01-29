include config.mk
include ../utils.mk

ARCH=linux_x86_64
TARBALL=$(NAME)_$(VERSION)_$(ARCH).tar.gz
GITHUB_REPO=https://github.com/charmbracelet/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	cd $(BUILD_PATH); \
	tar -xzf ../$(TARBALL)
#	mv $(NAME)-v$(VERSION)-$(ARCH) $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -R $(BUILD_PATH) $(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
