include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p "$(BUILD_HOME)"
	cd "$(BUILD_HOME)"; \
	curl -L -O "https://github.com/jonas/tig/releases/download/$(NAME)-$(VERSION)/$(TARBALL)"; \
	tar zxf $(TARBALL)

post_install:
	cd "$(BUILD_PATH)"; \
	make install-doc

