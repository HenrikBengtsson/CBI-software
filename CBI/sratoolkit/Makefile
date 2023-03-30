include config.mk
include ../utils.mk

TARBALL=$(NAME).$(VERSION)-centos_linux64.tar.gz
FTP_HOME=https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O $(FTP_HOME)/$(VERSION)/$(TARBALL); \
	tar zxf $(TARBALL); \
	mv $(NAME).$(VERSION)-centos_linux64 $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -pR $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@pattern="^[[:space:]]*([[:digit:]]+[.][[:digit:]]+([-.][[:digit:]]+)+)[/].*"; \
	curl --silent $(FTP_HOME)/ | pandoc --from=html --to=plain | grep -E "$$pattern" | tail -1 | sed -E "s/$$pattern/\1/"
