include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
TARBALL=$(NAME)-$(VERSION).tar.xz
GITHUB_REPO=https://github.com/newren/git-filter-repo

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar xf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -R $(BUILD_PATH) $(PREFIX)

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
