include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/FelixKrueger/$(NAME)

ifeq ($(VERSION_X),0)
  TARBALL=$(VERSION).tar.gz
  GITHUB_PATH=archive/refs/tags
else
  ARCH=linux-x86_64
  TARBALL=trim_galore-$(ARCH).tar.gz
  GITHUB_PATH=releases/download/v$(VERSION)
endif



## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/$(GITHUB_PATH)/$(TARBALL); \
	tar xzf "$(TARBALL)" -C "$(BUILD_PATH)" --strip-components=1

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

