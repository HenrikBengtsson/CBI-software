include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/criblio/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/scope-x86_64

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	chmod ugo+x scope-x86_64; \
	cp -p scope-x86_64 scope

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cp -p $(BUILD_PATH)/scope $(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
