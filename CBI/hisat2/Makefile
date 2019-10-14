include config.mk
include ../utils.mk

ZIPBALL=$(NAME)-$(VERSION)-Linux_x86_64.zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/$(ZIPBALL); \
	unzip $(ZIPBALL); \

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -pR $(BUILD_HOME)/$(NAME)-$(VERSION) $(SOFTWARE_HOME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
