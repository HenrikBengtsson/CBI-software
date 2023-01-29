include config.mk
include ../utils.mk

JARFILE=$(NAME).v$(VERSION).jar
GITHUB_REPO=https://github.com/dkoboldt/varscan

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH)
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/$(VERSION)/$(JARFILE)

$(BUILD_TARGET):
	cd $(BUILD_PATH); \
	ln -s $(JARFILE) $(NAME).jar

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
