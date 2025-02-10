include config.mk
include ../utils.mk

TARBALL=$(VERSION).tar.gz
GITHUB_REPO=https://github.com/HenrikBengtsson/shellcheck-repl

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/archive/refs/tags/$(TARBALL); \
	tar xf $(TARBALL)

## Make sure there is a default, so we can load the hidden module
## without having to specify the version, which is irrelevant
post_install_module:
	cd "$$(dirname "$(MODULE_TARGET)")"; \
	ln -fs "$(MODULE_TARGET)" default
	make write_protect_module

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent $(GITHUB_REPO)/tags | pandoc --from=html --to=plain | grep -E "^[[:space:]]+$(NAME) " | head -1 | sed -E 's/[[:space:]]+$(NAME) //'
