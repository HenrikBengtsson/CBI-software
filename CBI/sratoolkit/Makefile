include config.mk
include ../utils.mk

## sratoolkit (<= 3.2.0)
ARCH=centos_linux64

## sratoolkit (>= 3.2.1)
ARCH=alma_linux64

TARNAME=$(NAME).$(VERSION)-$(ARCH)
TARBALL=$(TARNAME).tar.gz
FTP_HOME=https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O $(FTP_HOME)/$(VERSION)/$(TARBALL); \
	tar zxf $(TARBALL); \
	mv $(TARNAME) $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -pR $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@pattern="^[[:space:]]*([[:digit:]]+[.][[:digit:]]+([-.][[:digit:]]+)+)[/].*"; \
	curl --silent $(FTP_HOME)/ | pandoc --from=html --to=plain | grep -E "$$pattern" | tail -1 | sed -E "s/$$pattern/\1/"
