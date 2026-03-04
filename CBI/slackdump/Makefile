include config.mk
include ../utils.mk


ARCH=linux_amd64
TARNAME=$(NAME)_$(VERSION)_$(ARCH)
TARBALL=$(TARNAME).pkg.tar.zst
GITHUB_REPO=https://github.com/rusq/slackdump

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar -xf "$(TARBALL)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH)/usr/* $(PREFIX)/
#	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

post_install:
	mkdir -p $(PREFIX)/share/man/man1
	mv $(PREFIX)/*.1 $(PREFIX)/share/man/man1

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
