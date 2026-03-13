include config.mk
include ../utils.mk

TARBALL=$(NAME)_v$(VERSION)_linux-amd64.tar.gz
GITHUB_REPO=https://github.com/coder/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://dist.ipfs.tech/kubo/v$(VERSION)/$(TARBALL); \
	tar -xf $(TARBALL); \
	mv kubo $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://dist.ipfs.tech/#kubo | pandoc --from=html --to=plain | grep -E "^v[[:digit:].]+" | tail -n 1 | sed 's/^v//'
