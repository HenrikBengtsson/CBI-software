include config.mk
include ../utils.mk

TARBALL=bedtools-$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/arq5x/bedtools2/releases/download/v$(VERSION)/$(TARBALL); \
	tar zxf $(TARBALL); \
	mv $(NAME) $(NAME)-$(VERSION)

$(INSTALL_TARGET):
	mkdir -p $(PREFIX); \
	cd $(BUILD_HOME); \
	cp -p -R $(NAME)-$(VERSION) $(PREFIX)/..
	touch $@




