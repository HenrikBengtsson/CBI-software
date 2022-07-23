include config.mk
include ../utils.mk


TARBALL=$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/HenrikBengtsson/port4me/archive/refs/tags/$(TARBALL); \
	tar xf "$(TARBALL)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cd "$(BUILD_PATH)"; \
	make install PREFIX=$(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
