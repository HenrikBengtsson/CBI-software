include config.mk
include ../utils.mk

ARCH=x86_64-unknown-linux-gnu
NAME2=difft
TARBALL=$(NAME2)-$(ARCH).tar.gz
GITHUB_REPO=https://github.com/Wilfred/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/$(VERSION)/$(TARBALL); \
	tar -xzf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	cp -R $(BUILD_PATH)/$(NAME2) $(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -E "^location:" | sed -E 's/.*(v|\/)//'
