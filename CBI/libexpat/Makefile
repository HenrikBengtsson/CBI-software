include config.mk
include ../utils.mk

TAG=R_$(subst .,_,$(VERSION))
TARBALL=expat-$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/libexpat/libexpat/releases/download/$(TAG)/$(TARBALL); \
	tar xf $(TARBALL); \
	mv expat-$(VERSION) $(NAME)-$(VERSION)
