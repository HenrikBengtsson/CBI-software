include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).src.tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -o $(TARBALL) https://sourceforge.net/projects/collectl/files/collectl/$(NAME)-$(VERSION)/$(TARBALL)/download; \
	tar -xf $(TARBALL); \
	mv $(NAME) $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)/{etc,usr/share/doc/collectl,usr/share/collectl}
	cd $(BUILD_PATH); \
	DESTDIR="$(PREFIX)" ./INSTALL
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
