include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
TARBALL=$(VERSION).tar.gz

$(DOWNLOAD_TARGET):
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/facebook/$(NAME)/archive/refs/tags/$(TARBALL); \
	tar xf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -R $(BUILD_PATH) $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

ifeq ($(VERSION),0.9.5)
post_install:
	sed -i "s/0.9.2/0.9.5/" $(PREFIX)/src/version.py
	make --quiet write_protect_install
endif

