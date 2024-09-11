include config.mk
include ../utils.mk

ARCH=Linux_x86_64
TARBALL=$(NAME)_$(VERSION)_$(ARCH).tar.gz ## glow (<= 1.5.0)
GITHUB_REPO=https://github.com/charmbracelet/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar -xzf $(TARBALL); \
	mv $(NAME)_$(VERSION)_$(ARCH) $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -R $(BUILD_PATH) "$$(dirname "$(PREFIX)")"
	mv "$(PREFIX)/manpages" "$(PREFIX)/man1"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
