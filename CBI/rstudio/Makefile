include config.mk
include ../utils.mk

VERSION_PLUS := $(shell echo "$(VERSION)" | sed -E 's/-([0-9]+)$$/+\1/g')
VERSION_URL := $(shell echo "$(VERSION)" | sed 's/+/%2B/g')
TARBALL=$(NAME)-$(VERSION_URL)-${ARCH}.tar.gz
URL_ROOT=https://download1.rstudio.org/desktop
URL=$(URL_ROOT)/centos7/x86_64/$(TARBALL)
ifeq ($(ARCH),amd64-debian)
  URL=$(URL_ROOT)/bionic/amd64/$(TARBALL)
endif

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O "$(URL)"; \
	tar zxf "$(TARBALL)"; \
	mv "$(NAME)-$(VERSION_PLUS)" "$(NAME)-$(VERSION)"


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
