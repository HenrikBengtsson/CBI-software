include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION)-x86_64-fedora.tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O "https://download1.rstudio.org/desktop/centos7/x86_64/$(TARBALL)"; \
	tar zxf "$(TARBALL)"

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	cd "$(BUILD_PATH)"; \
	find . -type f -name "*.so" -exec ldd {} 2> /dev/null ';' | grep -F "not found" > "$(CONFIG_TARGET).tmp" || true
	if grep -q -F "not found" "$(CONFIG_TARGET).tmp"; then \
	   { echo "ERROR: Missing system libraries:"; grep -F "not found" "$(CONFIG_TARGET).tmp" | uniq; } 1>&2; \
	   exit 1; \
	fi
	mv "$(CONFIG_TARGET).tmp" "$(CONFIG_TARGET)"

$(INSTALL_TARGET): $(CONFIG_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
