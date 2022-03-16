include config.mk
include ../utils.mk

TARBALL=bedtools-$(VERSION).tar.gz
URL=https://github.com/arq5x/bedtools2/releases/download/v$(VERSION)/$(TARBALL)
EXTNAME=$(NAME)

ifeq ($(VERSION_X_Y),2.16)
TARBALL=BEDTools.v$(VERSION).tar.gz
URL=https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bedtools/$(TARBALL)
EXTNAME=BEDTools-Version-$(VERSION)
endif

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(URL); \
	tar zxf $(TARBALL); \
	mv $(EXTNAME) $(BUILD_NAME)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX); \
	cd $(BUILD_HOME); \
	cp -p -R $(NAME)-$(VERSION) $(PREFIX)/..
	touch $@
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
