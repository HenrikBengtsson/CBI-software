include config.mk
include ../utils.mk

TARBALL=$(NAME)-x86_64-unknown-linux-musl.tar.xz
GITHUB_REPO=https://github.com/typst/typst

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar xJf $(TARBALL); \
	rm -rf $(BUILD_NAME); \
	mkdir -p $(BUILD_NAME)/bin; \
	mv $(NAME)-x86_64-unknown-linux-musl/typst $(BUILD_NAME)/bin/; \
	mv $(NAME)-x86_64-unknown-linux-musl/* $(BUILD_NAME)/; \
	rmdir $(NAME)-x86_64-unknown-linux-musl

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"/..
	cp -R $(BUILD_PATH) "$(PREFIX)"/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
