include config.mk
include ../utils.mk

JARFILE=$(NAME).v$(VERSION).jar


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH)
	cd $(BUILD_PATH); \
	curl -L -O https://github.com/dkoboldt/varscan/releases/download/$(VERSION)/$(JARFILE)

$(BUILD_TARGET):
	cd $(BUILD_PATH); \
	ln -s $(JARFILE) $(NAME).jar

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
