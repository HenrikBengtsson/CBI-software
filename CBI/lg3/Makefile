include config.mk
include ../utils.mk

TARBALL=$(VERSION).tar.gz
URL=https://github.com/UCSF-Costello-Lab/LG3_Pipeline/archive/refs/tags/$(TARBALL)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O $(URL); \
	tar zxf $(TARBALL); \
	mv LG3_Pipeline-$(VERSION) $(BUILD_NAME)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	cd $(PREFIX); make setup
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
