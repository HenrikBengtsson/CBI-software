include config.mk
include ../utils.mk


TARBALL=$(NAME)_$(VERSION)_$(ARCH).bz2
GITHUB_REPO=https://github.com/restic/restic

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	bunzip2 $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cd $(PREFIX); \
	cp -R $(BUILD_PATH) ..; \
	chmod ugo+x $(DOWNLOAD_TARGET_FILE); \
	ln -s $(DOWNLOAD_TARGET_FILE) $(NAME)
	mkdir -p "$(PREFIX)/man/man1"
	"$(PREFIX)/restic" generate --man="$(PREFIX)/man/man1"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
