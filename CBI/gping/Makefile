include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
ARCH=Linux-musl-x86_64
TARBALL=$(NAME)-$(ARCH).tar.gz

GITHUB_REPO=https://github.com/orf/gping

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/$(NAME)-v$(VERSION)/$(TARBALL); \
	tar xvfz $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	cp "$<" "$(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
