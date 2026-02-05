include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(TARBALL):
	$(error "Go to https://www.10xgenomics.com/support/software/cell-ranger/downloads and follow the curl/wget download instructions. Download '$@' to $(PWD)")

$(BUILD_HOME)/$(TARBALL): $(TARBALL)
	mkdir -p $(BUILD_HOME); \
	cp -p "$<" "$@"

$(DOWNLOAD_TARGET): $(BUILD_HOME)/$(TARBALL)
	cd $(BUILD_HOME); \
	tar xzf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -p -R $(BUILD_HOME)/$(NAME)-$(VERSION) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"


available-version:
	@curl --silent https://www.10xgenomics.com/support/software/cell-ranger/downloads | sed -E 's/.*cellranger-([[:digit:].]+)[.]tar[.]gz.*/\1/g'; echo

