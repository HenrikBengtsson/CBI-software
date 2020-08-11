include config.mk
include ../utils.mk

ARCH=x86_64

ifeq ($(VERSION),2.00a2LM)
        ZIPBALL=plink2_linux_$(ARCH)_20190810.zip
	UNZIP_NAME=
else ifeq ($(VERSION),2.00a3LM)
        ZIPBALL=plink2_linux_$(ARCH)_20200328.zip
        ZIPBALL=plink2_linux_$(ARCH)_20200727.zip
	UNZIP_NAME=
endif


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
