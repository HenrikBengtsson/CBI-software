include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
ARCH=linux_amd64
TARBALL=$(NAME)_$(ARCH).tar.gz

GITHUB_REPO=https://github.com/mikefarah/yq

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar xf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"/{bin,/share/man/man1}
	cd "$(BUILD_PATH)"; \
	cp "$<" "$(PREFIX)"/share/man/man1 && \
	cp -p "$(NAME)_$(ARCH)" "$(PREFIX)"/bin/yq

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
