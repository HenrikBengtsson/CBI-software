include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).zip
URL=https://github.com/broadinstitute/gatk/releases/download/$(VERSION)/$(TARBALL)

ifeq ($(VERSION_X),1)
  TARBALL=$(VERSION).zip
  URL=https://github.com/broadgsa/gatk-protected/archive/refs/tags/$(TARBALL)
endif


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -J -L -o "$(TARBALL)" "$(URL)"; \
	unzip "$(TARBALL)"; \
	if [[ -d "gatk-protected-$(VERSION)" ]]; then mv "gatk-protected-$(VERSION)" "$(BUILD_NAME)"; fi

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
