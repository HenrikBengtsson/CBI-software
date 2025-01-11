include config.mk
include ../utils.mk

ARCH=linux-amd64
TARBALL=$(NAME)$(VERSION).$(ARCH).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://go.dev/dl/$(TARBALL); \
	tar -xzf $(TARBALL); \
	mv go $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://go.dev/dl/ | xmllint --html --xpath '//span[contains(text(), "go")]' 2> /dev/null - | grep -E "^<span>go[[:digit:]]+([.][[:digit:]]+)+</span>$$" | head -1 | sed -E 's#(^<span>go|</span>$$)##g'


