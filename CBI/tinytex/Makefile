include config.mk
include ../utils.mk

TARBALL=TinyTeX-1-linux-x86_64-v$(VERSION).tar.xz
GITHUB_REPO=https://github.com/rstudio/tinytex-releases

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar xJf $(TARBALL); \
	rm -rf $(BUILD_NAME); \
	mv .TinyTeX $(BUILD_NAME)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"/..
	cp -R $(BUILD_PATH) "$(PREFIX)"/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
