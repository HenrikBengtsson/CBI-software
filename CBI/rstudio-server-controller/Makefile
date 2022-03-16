include config.mk
include ../utils.mk

TARBALL=$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/UCSF-CBI/rstudio-server-controller/archive/refs/tags/$(TARBALL); \
	tar xf "$(TARBALL)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	cd "$(BUILD_PATH)"; \
	cp *.md "$(PREFIX)"; \
	cp -R bin "$(PREFIX)"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

