include config.mk
include ../utils.mk

TARBALL=v$(VERSION).tar.gz

GITHUB_REPO=https://github.com/ho-tex/pdfcrop

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/archive/refs/tags/$(TARBALL); \
	tar -xzf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"/..
	cp -R $(BUILD_PATH) $(PREFIX)/..
	cd "$(PREFIX)"; \
	ln -s pdfcrop.pl pdfcrop; \
	rm -rf .gitignore build.lua tests/
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	curl --silent $(GITHUB_REPO)/tags | pandoc --from=html --to=plain | grep -E "^v[[:digit:]]+([.][[:digit:]]+)+$$" | sed -E 's/^v//' | head -1

