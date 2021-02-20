include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O https://github.com/akavel/$(NAME)/releases/download/v$(VERSION)/$(NAME)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	chmod ugo+x $(BUILD_PATH)/$(NAME)
	cp -R $(BUILD_PATH) $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
