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
	curl -L -O "https://github.com/rstudio/rstudio/archive/refs/tags/$(TARBALL)"; \
	tar zxf "$(TARBALL)"; \
	mv rstudio-$(VERSION) $(NAME)-$(VERSION)


## Tools required:
## * ant#
## * libyaml-cpp0.5v5 (https://github.com/jbeder/yaml-cpp)
$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cd "$(BUILD_PATH)"; \
	mkdir build; \
	cd build; \
	cmake .. -DRSTUDIO_TARGET=Server -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$(PREFIX)

$(INSTALL_TARGET): $(CONFIG_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
