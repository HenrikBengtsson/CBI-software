include config.mk
include ../utils.mk

ARCH=linux-amd64
TARBALL=$(NAME)_cli-$(ARCH).gz  ## a binary
GITHUB_REPO=https://github.com/duckdb/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	gunzip $(TARBALL); \
	mv $(NAME)_cli-$(ARCH) $(NAME); \
	chmod ugo+x $(NAME)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	cp -R $(BUILD_PATH)/$(NAME) $(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
