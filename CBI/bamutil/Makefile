include config.mk
include ../utils.mk

TARBALL=v$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/statgen/$(NAME)/archive/$(TARBALL); \
	tar -xzf $(TARBALL)

$(BUILD_TARGET):
	cd $(BUILD_PATH); \
	make cloneLib; \
	make

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH); \
	make install INSTALLDIR=$(PREFIX); \
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
