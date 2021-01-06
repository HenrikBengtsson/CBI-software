include config.mk
include ../utils.mk

VERSION_:=$(subst .,_,$(VERSION))

ZIPBALL=$(NAME)_v$(VERSION_)_core.zip
DOWNLOAD_URL=https://sourceforge.net/projects/snpeff/files/$(ZIPBALL)/download

ZIPBALL=$(NAME)_latest_core.zip
DOWNLOAD_URL=https://snpeff.blob.core.windows.net/versions/$(ZIPBALL)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)/$(NAME)-$(VERSION)
	cd $(BUILD_HOME)/$(NAME)-$(VERSION); \
	curl -J -L -O $(DOWNLOAD_URL); \
	unzip $(ZIPBALL); \
	rm $(ZIPBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -pR $(BUILD_HOME)/$(NAME)-$(VERSION) $(SOFTWARE_HOME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
