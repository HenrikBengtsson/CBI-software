include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/akavel/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(NAME)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	chmod ugo+x $(BUILD_PATH)/$(NAME)
	cp -R $(BUILD_PATH) $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
