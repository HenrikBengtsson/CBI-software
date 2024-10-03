include config.mk
include ../utils.mk

ARCH=x86_64
DATE=
ifeq ($(VERSION),2.00a2LM)
        DATE=20190810
	UNZIP_NAME=
else ifeq ($(VERSION),2.00a3LM)
        DATE=20200727
	UNZIP_NAME=
else ifeq ($(VERSION),2.00a5.14)
        DATE=20240820
	UNZIP_NAME=
endif
ZIPBALL=plink2_linux_$(ARCH)_$(DATE).zip

GITHUB_REPO=https://github.com/chrchang/plink-ng

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://s3.amazonaws.com/plink2-assets/alpha5/$(ZIPBALL); \
	unzip -d $(NAME)-$(VERSION) $(ZIPBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'

#	git tag | grep -E "^v2" | grep -v -E '[-][[:digit:]]{6}' | sed -E 's/^v//' | sed 's/a/.0./' | sed -E 's/-final$/.0/'
