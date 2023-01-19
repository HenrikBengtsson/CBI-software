include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/dariober/ASCIIGenome/releases/download/v$(VERSION)/$(NAME)-$(VERSION).zip; \
	unzip $(NAME)-$(VERSION).zip

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://raw.githubusercontent.com/dariober/ASCIIGenome/master/CHANGELOG.md | grep -E "^New in" | head -1 | sed -E 's/^New in *//'

