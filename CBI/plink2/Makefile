include config.mk
include ../utils.mk

ARCH=x86_64
DATE=
ifeq ($(VERSION),2.00a2LM)
        DATE=20190810
else ifeq ($(VERSION),2.00a3LM)
        DATE=20200727
else ifeq ($(VERSION),2.00a5.14)
        DATE=20240820
else ifeq ($(VERSION),2.0.0-a.5.15)
        DATE=20241007
else ifeq ($(VERSION),2.0.0-a.6.1)
        DATE=20241114
else ifeq ($(VERSION),2.0.0-a.6.4)
        DATE=20241206
endif
ZIPBALL=plink2_linux_$(ARCH)_$(DATE).zip


ZIPBALL=plink$(VERSION)_linux_avx2.zip

GITHUB_REPO=https://github.com/chrchang/plink-ng
ALPHA_VERSION=$(shell echo $(VERSION) | sed -E 's/.*a\.([0-9]+).*/\1/')

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://www.cog-genomics.org/static/bin/$(ZIPBALL); \
	unzip -d $(NAME)-$(VERSION) $(ZIPBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
