include config.mk
include ../utils.mk

TARBALL=$(VERSION).tar.gz
GIT_REPO=https://codeberg.org/smxi/$(NAME)


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GIT_REPO)/archive/$(TARBALL); \
	tar -xzf $(TARBALL); \
	mv "$(NAME)" "$(NAME)-$(VERSION)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -R $(BUILD_PATH) $(PREFIX)
	mkdir -p $(PREFIX)/{bin,share/man/man1}
	rm $(PREFIX)/.gitattributes
	mv $(PREFIX)/inxi.1 $(PREFIX)/share/man/man1/
	mv $(PREFIX)/inxi $(PREFIX)/bin/
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent $(GIT_REPO)/tags | pandoc --from=html --to=plain | grep -E "^[| ]+[[:digit:]]+([.-][[:digit:]]+)+ *.*" | head -n 1 | sed -E 's/[| ]//g'
