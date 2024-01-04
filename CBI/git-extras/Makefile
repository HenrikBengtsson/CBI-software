include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
TARBALL=$(VERSION).tar.gz
GITHUB_REPO=https://github.com/tj/git-extras

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/archive/$(TARBALL); \
	tar xvfz $(TARBALL)

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	make install PREFIX="$(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
