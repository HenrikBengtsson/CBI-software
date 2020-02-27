include config.mk
include ../utils.mk

ZIPNAME=$(NAME)-v$(VERSION)-linux-amd64
ZIPFILE=$(ZIPNAME).zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O https://downloads.rclone.org/v$(VERSION)/$(ZIPFILE); \
	unzip $(ZIPFILE); \
	mv $(ZIPNAME) $(BUILD_NAME)

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
