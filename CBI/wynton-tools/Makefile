include config.mk
include ../utils.mk

TARBALL=$(VERSION).tar.gz

GITHUB_REPO=https://github.com/ucsf-wynton/wynton-tools

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/archive/refs/tags/$(TARBALL); \
	tar xf "$(TARBALL)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -p -R "$(BUILD_PATH)" "$(PREFIX)/.."
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent $(GITHUB_REPO)/tags | pandoc --from=html --to=plain | grep -E "^[[:digit:]]+[.][[:digit:]]+[.][[:digit:]]+$$" | head -1 | sed -E 's/[[:space:]]+$(NAME) //'
