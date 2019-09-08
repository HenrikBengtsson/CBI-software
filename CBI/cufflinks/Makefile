include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).Linux_x86_64.tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://cole-trapnell-lab.github.io/cufflinks/assets/downloads/$(TARBALL); \
	tar xzf $(TARBALL); \
	mv $(NAME)-$(VERSION).Linux_x86_64 $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mv $(BUILD_HOME)/$(NAME)-$(VERSION) $(SOFTWARE_HOME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
