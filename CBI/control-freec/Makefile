include config.mk
include ../utils.mk

TARBALL=v$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/BoevaLab/$(NAME)/archive/v$(VERSION).tar.gz; \
	tar zxf $(TARBALL)


$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH)/src; \
	make; \
	mkdir -p ../bin; \
	cp freec ../bin


$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH)/{bin,data,scripts,README.md} $(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
