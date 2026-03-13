include config.mk
include ../utils.mk

TARBALL=$(NAME).mmulet.com-dont_forget_to_chmod_+x_this_file
GITHUB_OWNER=mmulet
GITHUB_REPO=$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH)
	cd $(BUILD_PATH); \
	curl -L -o $(NAME) https://github.com/$(GITHUB_OWNER)/$(GITHUB_REPO)/releases/download/$(VERSION)/$(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -p -R "$(BUILD_PATH)" "$(PREFIX)/.."
	chmod ugo+x "$(PREFIX)/$(NAME)"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	curl --head --silent "https://github.com/$(GITHUB_OWNER)/$(GITHUB_REPO)/releases/latest" | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'

