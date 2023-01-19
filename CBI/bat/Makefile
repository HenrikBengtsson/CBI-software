include config.mk
include ../utils.mk

ARCH=x86_64-unknown-linux-musl
TARBALL=$(NAME)-v$(VERSION)-$(ARCH).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/sharkdp/$(NAME)/releases/download/v$(VERSION)/$(TARBALL); \
	tar -xzf $(TARBALL); \
	mv $(NAME)-v$(VERSION)-$(ARCH) $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	mkdir -p "$(PREFIX)/share/man/man1"
	cp -R $(BUILD_PATH) $(PREFIX)/..
	mv "$(PREFIX)/bat.1" "$(PREFIX)/share/man/man1"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://raw.githubusercontent.com/sharkdp/bat/master/CHANGELOG.md | grep -E "^# +v[[:digit:].]+" | head -n 1 | sed -E 's/^# *v//'
