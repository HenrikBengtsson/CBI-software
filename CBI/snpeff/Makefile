include config.mk
include ../utils.mk

VERSION_:=$(subst .,_,$(VERSION))
ZIPBALL=$(NAME)_v$(VERSION_)_core.zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)/$(NAME)-$(VERSION)
	cd $(BUILD_HOME)/$(NAME)-$(VERSION); \
	curl -J -L -O https://sourceforge.net/projects/snpeff/files/$(ZIPBALL)/download; \
	unzip $(ZIPBALL); \
	rm $(ZIPBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -pR $(BUILD_HOME)/$(NAME)-$(VERSION) $(SOFTWARE_HOME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
