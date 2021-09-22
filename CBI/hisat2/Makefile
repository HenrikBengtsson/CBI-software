include config.mk
include ../utils.mk

VERSION_NO_DOTS=$(subst .,,$(VERSION))
ZIPBALL=$(NAME)-$(VERSION_NO_DOTS)-Linux_x86_64.zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -o $(ZIPBALL) -L -O https://cloud.biohpc.swmed.edu/index.php/s/hisat2-$(VERSION_NO_DOTS)-Linux_x86_64/download; \
	unzip $(ZIPBALL); \

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	cp -pR $(BUILD_PATH); \
	module --force purge; \
	make hisat2-align-s hisat2-build-s hisat2-inspect-s

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -pR $(BUILD_HOME)/$(NAME)-$(VERSION) $(SOFTWARE_HOME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
