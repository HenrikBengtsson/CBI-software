include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION)-linux-x86_64.zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/BenLangmead/bowtie2/releases/download/v$(VERSION)/$(TARBALL); \
	unzip $(TARBALL); \
	mv $(NAME)-$(VERSION)-linux-x86_64 $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
