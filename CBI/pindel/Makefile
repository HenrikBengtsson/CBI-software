include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/genome/${NAME}/archive/v${VERSION}.tar.gz; \
	tar zxf v${VERSION}.tar.gz

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	module purge; \
	module load CBI htslib; \
	HTSLIB_PATH="$$(dirname $$(dirname $$(which htsfile)))"; \
	echo "HTSLIB_PATH=$${HTSLIB_PATH}"; \
	cd $(BUILD_PATH); \
	module list; \
	LIBRARY_PATH="$${HTSLIB_PATH}/lib" ./INSTALL $${HTSLIB_PATH}

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install_software
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
