include config.mk
include ../utils.mk

ifndef ACCESS_TOKEN
  $(error ERROR: Environment variable 'ACCESS_TOKEN' is not set)
endif

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -o $(TARBALL) "http://cf.10xgenomics.com/releases/cell-exp/$(NAME)-$(VERSION).tar.gz?$(ACCESS_TOKEN)"; \
	tar xzf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -p -R $(BUILD_HOME)/$(NAME)-$(VERSION) $(PREFIX)/..
	make post_install_software
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
