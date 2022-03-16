include config.mk
include ../utils.mk

TARBALL=$(NAME)$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -J -L -O https://sourceforge.net/projects/expect/files/Expect/$(VERSION)/$(TARBALL)/download; \
	tar xf $(TARBALL); \
	mv "$(NAME)$(VERSION)" "$(NAME)-$(VERSION)"

post_install:
	mkdir -p ${PREFIX}/{bin,libs,share/man/man1}
	cd $(PREFIX); rm -f -- *.c *.h *.o *.in *.m4 config* Makefile* INSTALL
	cd $(PREFIX); mv expect fixline1 bin/
	cd $(PREFIX); mv libexpect5.45.4.so libs/
	cd $(PREFIX); for ff in *.man; do \
	    mv "$${ff}" "share/man/man1/$${ff/.man/.1}"; \
	done
	make write_protect_install

$(INSTALL_TARGET): $(CONFIG_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
