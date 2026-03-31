include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/browsh-org/browsh

ARCH=linux_amd64
TARBALL=$(NAME)_$(VERSION)_$(ARCH)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp "$<" $(PREFIX)/browsh
	chmod ugo+x $(PREFIX)/browsh
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://www.brow.sh/downloads/ | grep -F "latest release:" | sed 's/.* latest release: *v//' | sed 's/<.*//'

