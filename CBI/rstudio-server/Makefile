include config.mk
include ../utils.mk

VERSION_PLUS := $(shell echo "$(VERSION)" | sed -E 's/-([0-9]+)$$/+\1/g')
TARBALL=v$(VERSION_PLUS).tar.gz


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	[[ -f "$(TARBALL)" ]] || curl -L -O "https://github.com/rstudio/rstudio/archive/refs/tags/$(TARBALL)"; \
	tar zxf "$(TARBALL)"; \
	mv rstudio-$(VERSION) $(NAME)-$(VERSION)


rstudio-tools: $(BUILD_PATH)/rstudio-tools/yaml-cpp $(BUILD_PATH)/rstudio-tools/boost $(BUILD_PATH)/rstudio-tools/dictionaries $(BUILD_PATH)/rstudio-tools/mathjax $(BUILD_PATH)/rstudio-tools/pandoc $(BUILD_PATH)/rstudio-tools/soci $(BUILD_PATH)/dependencies/common/node

$(BUILD_PATH)/rstudio-tools: $(DOWNLOAD_TARGET)
	mkdir -p "$@"

$(BUILD_PATH)/dependencies/common/node: $(DOWNLOAD_TARGET)
	cd ${BUILD_PATH)/dependencies/common/; \
	install-$(@F)

$(BUILD_PATH)/rstudio-tools/%: $(BUILD_PATH)/rstudio-tools
	export RSTUDIO_TOOLS_ROOT=$<; \
	$(BUILD_PATH)/dependencies/common/install-$(@F)

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cd "$(BUILD_PATH)"; \
	mkdir -p build; \
	cd build; \
	module load CBI apache-ant; \
	export RSTUDIO_TOOLS_ROOT=$(BUILD_PATH)/rstudio-tools; \
	cmake .. -DRSTUDIO_TARGET=Server -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$(PREFIX)

$(BUILD_TARGET): $(CONFIG_TARGET)
	cd "$(BUILD_PATH)/build"; \
	make preinstall

$(INSTALL_TARGET): $(BUILD_TARGET)
	cd "$(BUILD_PATH)/build"; \
	make install
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
