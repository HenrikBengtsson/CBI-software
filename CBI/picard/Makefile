include config.mk
include ../utils.mk

TARBALL=$(VERSION)/$(NAME).jar
URL=https://github.com/broadinstitute/picard/releases/download/$(TARBALL)

ifeq ($(VERSION),1.64)
TARBALL=picard-tools-$(VERSION).zip
URL=https://downloads.sourceforge.net/project/picard/picard-tools/1.64/$(TARBALL)
endif


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH)
	cd $(BUILD_PATH); \
	curl -L -O $(URL)
ifeq ($(VERSION),1.64)
	cd $(BUILD_PATH); \
	unzip -d .. $(TARBALL)
	rm -rf $(BUILD_PATH)
	cd $(BUILD_HOME); \
	mv picard-tools-$(VERSION) $(BUILD_NAME)
	touch $(BUILD_PATH)/$(DOWNLOAD_TARGET_FILE)
endif

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
ifeq ($(VERSION),1.64)
	rm $(PREFIX)/$(DOWNLOAD_TARGET_FILE)
endif
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
