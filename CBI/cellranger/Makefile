include config.mk
include ../utils.mk


TARBALL=$(NAME)-$(VERSION).tar.xz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(TARBALL):
	$(error "Go to https://www.10xgenomics.com/support/software/cell-ranger/downloads and follow the curl/wget *.xz download instructions. Download '$@' to $(PWD)")

$(BUILD_HOME)/$(TARBALL): $(TARBALL)
	mkdir -p $(BUILD_HOME); \
	cp -p "$<" "$@"

$(DOWNLOAD_TARGET): $(BUILD_HOME)/$(TARBALL)
	cd $(BUILD_HOME); \
	tar xf $(TARBALL); \
	touch $(DOWNLOAD_TARGET)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -p -R $(BUILD_HOME)/$(NAME)-$(VERSION) $(PREFIX)/..
	rm $(PREFIX)/.downloaded
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"


available-version:
	@curl --silent https://www.10xgenomics.com/support/software/cell-ranger/downloads | sed -E 's/.*cellranger-([[:digit:].]+)[.]tar[.]xz.*/\1/g'; echo

