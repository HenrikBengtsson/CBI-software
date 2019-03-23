include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -J -L -O https://github.com/broadinstitute/gatk/releases/download/$(VERSION)/$(NAME)-$(VERSION).zip; \
	unzip $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
