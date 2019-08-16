include config.mk
include ../utils.mk

ARCH=x86_64
ZIPBALL=plink2_linux_$(ARCH)_20190810.zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://s3.amazonaws.com/plink2-assets/$(ZIPBALL); \
	unzip -d $(NAME)-$(VERSION) $(ZIPBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
