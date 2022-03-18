include config.mk
include ../utils.mk

TARBALL=Lmod-$(VERSION).tar.bz2

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O "https://sourceforge.net/projects/lmod/files/$(TARBALL)"; \
	tar xf "$(TARBALL)"; \
	mv Lmod-$(VERSION) $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(CONFIG_TARGET)
	cd $(BUILD_PATH); make pre-install
	echo PREFIX=$(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

