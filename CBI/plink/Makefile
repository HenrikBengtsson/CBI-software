include config.mk
include ../utils.mk

ARCH=x86_64

ifeq ($(VERSION),1.07)
	ZIPBALL=plink1_linux_$(ARCH).zip
	DOWNLOAD_URL=https://s3.amazonaws.com/plink1-assets/$(VERSION)/$(ZIPBALL)
	UNZIP_NAME=$(NAME)-$(VERSION)-$(ARCH)
else ifeq ($(VERSION),1.90b6.10)
	ZIPBALL=plink_linux_$(ARCH)_20190617.zip
else ifeq ($(VERSION),1.90b6.16)
	ZIPBALL=plink_linux_$(ARCH)_20200219.zip
	DOWNLOAD_URL=https://s3.amazonaws.com/plink1-assets/$(ZIPBALL)
	UNZIP_NAME=
else ifeq ($(VERSION),1.90b6.18)
	ZIPBALL=plink_linux_$(ARCH)_20200616.zip
	DOWNLOAD_URL=https://s3.amazonaws.com/plink1-assets/$(ZIPBALL)
	UNZIP_NAME=
else ifeq ($(VERSION),1.90b6.21)
	ZIPBALL=plink_linux_$(ARCH)_20201019.zip
	DOWNLOAD_URL=https://s3.amazonaws.com/plink1-assets/$(ZIPBALL)
	UNZIP_NAME=
else ifeq ($(VERSION),1.90b6.24)
	ZIPBALL=plink_linux_$(ARCH)_20210606.zip
	DOWNLOAD_URL=https://s3.amazonaws.com/plink1-assets/$(ZIPBALL)
	UNZIP_NAME=
else ifeq ($(VERSION),1.90b6.25)
	ZIPBALL=plink_linux_$(ARCH)_20220305.zip
	DOWNLOAD_URL=https://s3.amazonaws.com/plink1-assets/$(ZIPBALL)
	UNZIP_NAME=
else ifeq ($(VERSION),1.90b6.26)
	ZIPBALL=plink_linux_$(ARCH)_20220402.zip
	DOWNLOAD_URL=https://s3.amazonaws.com/plink1-assets/$(ZIPBALL)
	UNZIP_NAME=
endif


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(DOWNLOAD_URL); \
	if [[ -z "$(UNZIP_NAME)" ]]; then \
	  unzip -d $(NAME)-$(VERSION) $(ZIPBALL); \
	else \
	  unzip $(ZIPBALL); \
	  mv $(NAME)-$(VERSION)-$(ARCH) $(NAME)-$(VERSION); \
	fi

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
