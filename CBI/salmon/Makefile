include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION)_linux_x86_64.tar.gz


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/COMBINE-lab/$(NAME)/releases/download/v$(VERSION)/$(TARBALL); \
	tar zxf $(TARBALL); \
	mv salmon-*_linux_x86_64 $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

## Patch for bug https://github.com/COMBINE-lab/salmon/issues/761
ifeq ($(VERSION),1.8.0)
post_install:
	chmod -R go+r $(PREFIX)
	chmod   ugo+x $(PREFIX)/{bin,lib,bin/salmon}
endif
