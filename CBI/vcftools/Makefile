include config.mk
include ../utils.mk

#TARBALL=v$(VERSION).tar.gz


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/vcftools/$(NAME)/releases/download/v$(VERSION)/$(TARBALL); \
	tar xzf $(TARBALL)
