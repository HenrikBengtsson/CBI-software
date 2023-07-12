include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/mpalmer/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/action-validator_linux_amd64

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	chmod ugo+x $(BUILD_PATH)/action-validator_linux_amd64

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cp $(BUILD_PATH)/action-validator_linux_amd64 $@
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
