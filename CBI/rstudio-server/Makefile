include config.mk

TAIL:=$(VERSION)
RSTUDIO_VERSION_MAJOR:=$(shell echo "$(TAIL)" | sed -E 's/[^[:digit:]][^.]*//g')
TAIL:=$(shell echo "$(TAIL)" | sed "s/$(RSTUDIO_VERSION_MAJOR)[.]//")
RSTUDIO_VERSION_MINOR:=$(shell echo "$(TAIL)" | sed -E 's/[^[:digit:]][^.]*//g')
TAIL:=$(shell echo "$(TAIL)" | sed "s/$(RSTUDIO_VERSION_MINOR)[.]//")
RSTUDIO_VERSION_PATCH:=$(shell echo "$(TAIL)" | sed -E 's/[^[:digit:]][^.]*//g')
TAIL:=$(shell echo "$(TAIL)" | sed "s/$(RSTUDIO_VERSION_PATCH)//")
RSTUDIO_VERSION_SUFFIX:=$(TAIL)

VERSION_MINUS:=$(RSTUDIO_VERSION_MAJOR).$(RSTUDIO_VERSION_MINOR).$(RSTUDIO_VERSION_PATCH)$(shell echo "$(RSTUDIO_VERSION_SUFFIX)" | tr '+' '-')
VERSION_PLUS:=$(RSTUDIO_VERSION_MAJOR).$(RSTUDIO_VERSION_MINOR).$(RSTUDIO_VERSION_PATCH)$(shell echo "$(RSTUDIO_VERSION_SUFFIX)" | tr '-' '+')
VERSION:=$(VERSION_MINUS)

include ../utils.mk

TARBALL=v$(VERSION_PLUS).tar.gz

debug3:
	@echo "VERSION=$(VERSION)"
	@echo "RSTUDIO_VERSION_MAJOR=$(RSTUDIO_VERSION_MAJOR)"
	@echo "RSTUDIO_VERSION_MINOR=$(RSTUDIO_VERSION_MINOR)"
	@echo "RSTUDIO_VERSION_PATCH=$(RSTUDIO_VERSION_PATCH)"
	@echo "RSTUDIO_VERSION_SUFFIX=$(RSTUDIO_VERSION_SUFFIX)"
	@echo "VERSION_MINUS=$(VERSION_MINUS)"
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
	echo "Now run 'make rstudio-tools'"


rstudio-tools: $(BUILD_PATH)/rstudio-tools/yaml-cpp $(BUILD_PATH)/rstudio-tools/boost $(BUILD_PATH)/rstudio-tools/dictionaries $(BUILD_PATH)/rstudio-tools/mathjax $(BUILD_PATH)/rstudio-tools/pandoc $(BUILD_PATH)/rstudio-tools/soci $(BUILD_PATH)/dependencies/common/node $(BUILD_PATH)/rstudio-tools/quarto $(BUILD_PATH)/rstudio-tools/panmirror
	echo "Now run 'make all'"

$(BUILD_PATH)/rstudio-tools: $(DOWNLOAD_TARGET)
	mkdir -p "$@"

$(BUILD_PATH)/dependencies/common/node: $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH)/dependencies/common/; \
	./install-npm-dependencies

$(BUILD_PATH)/rstudio-tools/%: $(BUILD_PATH)/rstudio-tools
	module purge; \
	module try-load $(CONFIG_MODULES); \
	export RSTUDIO_TOOLS_ROOT=$<; \
	$(BUILD_PATH)/dependencies/common/install-$(@F)

## FIXME/TMP /2023-04-16
#PREFIX=/wynton/home/cbi/shared/software/CBI/rstudio-server-2023.03.0-386-1
INSTALL_TARGET=$(PREFIX)/bin/rserver

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cd "$(BUILD_PATH)"; \
	mkdir -p build; \
	cd build; \
	module purge; \
	module try-load $(CONFIG_MODULES); \
	command -v ant &> /dev/null || module try-load CBI apache-ant; \
	command -v ant &> /dev/null || { 2>&1 echo "ERROR: Missing software: ant"; exit 1; }; \
	JAVA_XY=$$(java -version 2>&1 | grep version | sed -E 's/(.* "|".*$$)//g'); \
	[[ $$JAVA_XY =~ 1.8.* ]] || { 2>&1 echo "ERROR: Requires Java v1.8: $$JAVA_XY"; exit 1; }; \
	module list; \
	export RSTUDIO_TOOLS_ROOT=$(BUILD_PATH)/rstudio-tools;     \
	export RSTUDIO_VERSION_MAJOR="$(RSTUDIO_VERSION_MAJOR)";   \
	export RSTUDIO_VERSION_MINOR="$(RSTUDIO_VERSION_MINOR)";   \
	export RSTUDIO_VERSION_PATCH="$(RSTUDIO_VERSION_PATCH)";   \
	export RSTUDIO_VERSION_SUFFIX="$(RSTUDIO_VERSION_SUFFIX)"; \
	cmake .. -DRSTUDIO_TARGET=Server -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$(PREFIX) || rm "$@"

$(BUILD_TARGET): $(CONFIG_TARGET)
	cd "$(BUILD_PATH)/build"; \
	module purge; \
	module try-load $(CONFIG_MODULES); \
	module list; \
	export RSTUDIO_TOOLS_ROOT=$(BUILD_PATH)/rstudio-tools;     \
	export RSTUDIO_TOOLS_ROOT=$(BUILD_PATH)/rstudio-tools;     \
	export RSTUDIO_VERSION_MAJOR="$(RSTUDIO_VERSION_MAJOR)";   \
	export RSTUDIO_VERSION_MINOR="$(RSTUDIO_VERSION_MINOR)";   \
	export RSTUDIO_VERSION_PATCH="$(RSTUDIO_VERSION_PATCH)";   \
	export RSTUDIO_VERSION_SUFFIX="$(RSTUDIO_VERSION_SUFFIX)"; \
	make preinstall

$(INSTALL_TARGET): $(BUILD_TARGET)
	if [[ -f "$@" ]]; then \
	  >&2 echo "ERROR: Installation failed. Target file already exists: $@"; \
	  exit 1; \
	fi
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

available-version:
#	@curl --silent https://docs.posit.co/ide/news/ | pandoc --from=html --to=plain | grep -E "RStudio [[:digit:]]+[.][[:digit:]]+[.][[:digit:]]+\b" | sed -E 's/^(-[[:space:]]+|)RStudio //' | uniq | head -1
	@curl --silent https://github.com/rstudio/rstudio/tags | pandoc --from=html --to=plain | grep -E "^v?[[:digit:]]+[.][[:digit:]]+[.][[:digit:]]+" | sed -E 's/^v//' | head -1 | sed 's/+/-/'

FORCE:

