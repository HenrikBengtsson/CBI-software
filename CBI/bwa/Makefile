include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).tar.bz2

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -J -L -O https://sourceforge.net/projects/bio-bwa/files/$(TARBALL)/download; \
	tar jxf $(TARBALL)

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	module --force purge; \
	make; \
	mkdir -p man/man1/; \
	ln -s ../../bwa.1 man/man1/bwa.1
	make post_build

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	module --force purge; \
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
