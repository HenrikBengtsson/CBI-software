include config.mk
include ../utils.mk

ZIPBALL=$(NAME)_$(VERSION).zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O https://data.broadinstitute.org/igv/projects/downloads/$(VERSION_X_Y)/$(ZIPBALL); \
	unzip $(ZIPBALL); \
	mv $(NAME)_$(VERSION) $(NAME)-$(VERSION); \

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -pR $(BUILD_HOME)/$(NAME)-$(VERSION) $(SOFTWARE_HOME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
