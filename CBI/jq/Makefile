include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/jqlang/jq

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/$(NAME)-$(VERSION)/$(TARBALL); \
	tar xf "$(TARBALL)"


available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//' | sed -E 's/^jq-//'
