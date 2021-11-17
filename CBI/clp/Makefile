include config.mk
include ../utils.mk


TARBALL=$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O "https://github.com/coin-or/Clp/archive/refs/tags/releases/$(TARBALL)"; \
	tar xvfz $(TARBALL); \
	mv $(NAME)-releases-$(VERSION) $(BUILD_NAME)

