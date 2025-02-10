include config.mk
include ../utils.mk

ARCH=linux_amd64
TARBALL=$(NAME)_$(VERSION)_$(ARCH).tar.gz
GITHUB_REPO=https://github.com/zmwangx/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar -xzf $(TARBALL) -C $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	mkdir -p "$(PREFIX)/share/man/man1"
	cp -R $(BUILD_PATH) $(PREFIX)/..
	mv "$(PREFIX)/ets.1" "$(PREFIX)/share/man/man1"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
