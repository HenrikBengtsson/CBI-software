include config.mk
include ../utils.mk

TARBALL=$(NAME).$(VERSION)-centos_linux64.tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.10.0/$(TARBALL); \
	tar zxf $(TARBALL); \
	mv $(NAME).$(VERSION)-centos_linux64 $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -pR $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
