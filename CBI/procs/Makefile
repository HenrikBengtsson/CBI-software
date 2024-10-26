include config.mk
include ../utils.mk

ARCH=x86_64-linux
TARBALL=$(NAME)-v$(VERSION)-$(ARCH).zip
GITHUB_REPO=https://github.com/dalance/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	unzip $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	cp $(BUILD_HOME)/procs $(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
