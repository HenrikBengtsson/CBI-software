include config.mk
include ../utils.mk

ZIPBALL=$(NAME)-$(VERSION)-Linux_x86_64.zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -o $(ZIPBALL) -L -O https://cloud.biohpc.swmed.edu/index.php/s/hisat2-220-Linux_x86_64/download; \
	unzip $(ZIPBALL); \

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	cp -pR $(BUILD_PATH); \
	make hisat2-align-s hisat2-build-s hisat2-inspect-s

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -pR $(BUILD_HOME)/$(NAME)-$(VERSION) $(SOFTWARE_HOME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
