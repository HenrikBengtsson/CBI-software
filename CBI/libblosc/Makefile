include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/Blosc/c-blosc
TARBALL=v$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/archive/refs/tags/$(TARBALL); \
	tar xvfz $(TARBALL); \
	mv "c-blosc-$(VERSION)" "$(NAME)-$(VERSION)"


$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(BUILD_PATH)/build"
	cd "$(BUILD_PATH)/build"; \
	module purge; \
	module try-load $(CONFIG_MODULES); \
	cmake .. -DCMAKE_INSTALL_PREFIX="$(PREFIX)"

$(BUILD_TARGET): $(CONFIG_TARGET)
	cd "$(BUILD_PATH)/build"; \
	module purge; \
	module try-load $(BUILD_MODULES); \
	cmake --build .

$(INSTALL_TARGET): $(BUILD_TARGET)
	cd "$(BUILD_PATH)/build"; \
	module purge; \
	module try-load $(BUILD_MODULES); \
        cmake --build . --target install

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
