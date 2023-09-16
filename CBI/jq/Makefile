include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/jqlang/jq/releases/download/$(NAME)-$(VERSION)/$(TARBALL); \
	tar xf "$(TARBALL)"

#$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
#	chmod ugo+x $(BUILD_PATH)/$(NAME)
#	cp -R $(BUILD_PATH) $(PREFIX)
#	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
