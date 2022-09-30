include config.mk
include ../utils.mk

TAIL:=$(VERSION)
RSTUDIO_VERSION_MAJOR:=$(shell echo "$(TAIL)" | sed -E 's/[^[:digit:]][^.]*//g')
TAIL:=$(shell echo "$(TAIL)" | sed "s/$(RSTUDIO_VERSION_MAJOR)[.]//")
RSTUDIO_VERSION_MINOR:=$(shell echo "$(TAIL)" | sed -E 's/[^[:digit:]][^.]*//g')
TAIL:=$(shell echo "$(TAIL)" | sed "s/$(RSTUDIO_VERSION_MINOR)[.]//")
RSTUDIO_VERSION_PATCH:=$(shell echo "$(TAIL)" | sed -E 's/[^[:digit:]][^.]*//g')
TAIL:=$(shell echo "$(TAIL)" | sed "s/$(RSTUDIO_VERSION_PATCH)//")
RSTUDIO_VERSION_SUFFIX:=$(TAIL)

VERSION_PLUS:=$(RSTUDIO_VERSION_MAJOR).$(RSTUDIO_VERSION_MINOR).$(RSTUDIO_VERSION_PATCH)$(shell echo "$(RSTUDIO_VERSION_SUFFIX)" | tr '-' '+')
TARBALL=v$(VERSION_PLUS).tar.gz

debug3:
	@echo "VERSION=$(VERSION)"
	@echo "RSTUDIO_VERSION_MAJOR=$(RSTUDIO_VERSION_MAJOR)"
	@echo "RSTUDIO_VERSION_MINOR=$(RSTUDIO_VERSION_MINOR)"
	@echo "RSTUDIO_VERSION_PATCH=$(RSTUDIO_VERSION_PATCH)"
	@echo "RSTUDIO_VERSION_SUFFIX=$(RSTUDIO_VERSION_SUFFIX)"
	@echo "VERSION_PLUS=$(VERSION_PLUS)"


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	[[ -f "$(TARBALL)" ]] || curl -L -O "https://github.com/rstudio/rstudio/archive/refs/tags/$(TARBALL)"; \
	tar zxf "$(TARBALL)"; \
	mv rstudio-$(VERSION) $(NAME)-$(VERSION)


rstudio-tools: $(BUILD_PATH)/rstudio-tools/yaml-cpp $(BUILD_PATH)/rstudio-tools/boost $(BUILD_PATH)/rstudio-tools/dictionaries $(BUILD_PATH)/rstudio-tools/mathjax $(BUILD_PATH)/rstudio-tools/pandoc $(BUILD_PATH)/rstudio-tools/soci $(BUILD_PATH)/dependencies/common/node $(BUILD_PATH)/rstudio-tools/quarto

$(BUILD_PATH)/rstudio-tools: $(DOWNLOAD_TARGET)
	mkdir -p "$@"

$(BUILD_PATH)/dependencies/common/node: $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH)/dependencies/common/; \
	./install-npm-dependencies

$(BUILD_PATH)/rstudio-tools/%: $(BUILD_PATH)/rstudio-tools
	module purge; \
	module try-load CBI cmake jq scl-devtoolset; \
	export RSTUDIO_TOOLS_ROOT=$<; \
	$(BUILD_PATH)/dependencies/common/install-$(@F)

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cd "$(BUILD_PATH)"; \
	mkdir -p build; \
	cd build; \
	module purge; \
	module try-load CBI cmake jq scl-devtoolset; \
	command -v ant &> /dev/null || module try-load CBI apache-ant; \
	module list; \
	export RSTUDIO_TOOLS_ROOT=$(BUILD_PATH)/rstudio-tools;     \
	export RSTUDIO_VERSION_MAJOR="$(RSTUDIO_VERSION_MAJOR)";   \
	export RSTUDIO_VERSION_MINOR="$(RSTUDIO_VERSION_MINOR)";   \
	export RSTUDIO_VERSION_PATCH="$(RSTUDIO_VERSION_PATCH)";   \
	export RSTUDIO_VERSION_SUFFIX="$(RSTUDIO_VERSION_SUFFIX)"; \
	cmake .. -DRSTUDIO_TARGET=Server -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$(PREFIX) || rm "$@"

$(BUILD_TARGET): $(CONFIG_TARGET)
	cd "$(BUILD_PATH)/build"; \
	export RSTUDIO_TOOLS_ROOT=$(BUILD_PATH)/rstudio-tools;     \
	export RSTUDIO_VERSION_MAJOR="$(RSTUDIO_VERSION_MAJOR)";   \
	export RSTUDIO_VERSION_MINOR="$(RSTUDIO_VERSION_MINOR)";   \
	export RSTUDIO_VERSION_PATCH="$(RSTUDIO_VERSION_PATCH)";   \
	export RSTUDIO_VERSION_SUFFIX="$(RSTUDIO_VERSION_SUFFIX)"; \
	make preinstall

$(INSTALL_TARGET): $(BUILD_TARGET)
	cd "$(BUILD_PATH)/build"; \
	export RSTUDIO_TOOLS_ROOT=$(BUILD_PATH)/rstudio-tools;     \
	export RSTUDIO_VERSION_MAJOR="$(RSTUDIO_VERSION_MAJOR)";   \
	export RSTUDIO_VERSION_MINOR="$(RSTUDIO_VERSION_MINOR)";   \
	export RSTUDIO_VERSION_PATCH="$(RSTUDIO_VERSION_PATCH)";   \
	export RSTUDIO_VERSION_SUFFIX="$(RSTUDIO_VERSION_SUFFIX)"; \
	make install
	[[ -f "$@" ]] || { >&2 echo "ERROR: Installation failed. No such target file: $@"; exit 1; }
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
