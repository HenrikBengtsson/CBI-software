include config.mk
include ../utils.mk


TARBALL=$(VERSION).tar.gz
GITHUB_REPO=https://github.com/HenrikBengtsson/port4me

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/archive/refs/tags/$(TARBALL); \
	tar xf "$(TARBALL)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cd "$(BUILD_PATH)"/bash; \
	make install PREFIX=$(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent $(GITHUB_REPO)/tags | pandoc --from=html --to=plain | grep -E "^[[:digit:]]+[.][[:digit:]]+[.][[:digit:]]+$$" | head -1 | sed -E 's/[[:space:]]+$(NAME) //'
