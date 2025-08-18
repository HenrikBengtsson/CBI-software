include config.mk
include ../utils.mk

ARCH=linux-amd64
TARBALL=$(NAME2)-$(ARCH)
GITHUB_REPO=https://github.com/kovidgoyal/$(NAME)


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
        chmod ugo+x $(TARBALL); \
	mv $(TARBALL) $(NAME2)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	cp -p $(BUILD_PATH)/$(NAME2) $(PREFIX)/kitten
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
