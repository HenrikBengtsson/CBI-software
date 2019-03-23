include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).Linux_x86_64.tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O http://ccb.jhu.edu/software/tophat/downloads/$(TARBALL); \
	tar zxf $(TARBALL); \
	mv $(NAME)-$(VERSION).Linux_x86_64 $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
