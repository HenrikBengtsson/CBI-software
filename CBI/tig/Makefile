include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/jonas/tig

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p "$(BUILD_HOME)"
	cd "$(BUILD_HOME)"; \
	curl -L -O "$(GITHUB_REPO)/releases/download/$(NAME)-$(VERSION)/$(TARBALL)"; \
	tar zxf $(TARBALL)

post_install:
	cd "$(BUILD_PATH)"; \
	make install-doc
	make write_protect_module

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|-|\/)//'
