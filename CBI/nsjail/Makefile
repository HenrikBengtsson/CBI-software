include config.mk
include ../utils.mk

TARBALL=$(VERSION).tar.gz
GITHUB_REPO=https://github.com/google/nsjail

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	git clone --depth 1 --branch "$(VERSION)" https://github.com/google/nsjail.git .

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH); \
	cp -R configs $(PREFIX); \
	cp LICENSE README.md nsjail $(PREFIX); \
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
