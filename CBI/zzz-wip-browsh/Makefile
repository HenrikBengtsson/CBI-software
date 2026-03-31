include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/browsh-org/browsh

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(DOWNLOAD_TARGET_FILE)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp "$<" $(PREFIX)/browsh
	chmod ugo+x $(PREFIX)/browsh
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
