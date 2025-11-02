include config.mk
include ../utils.mk

## PROJ (>= 6.3.0) requires sqlite3 (>= 3.11)

## PROJ (>= 9.7.0) requires C++17, CMake (>= 3.16), sqlite3 (>= 3.11),
## libtiff >= 4.0 (optional), curl >= 7.29.0 (optional)
## All available on Rocky 8, except C++17 requires scl-gcc-toolset
ifeq ($(VERSION_X),9)
    CONFIG_MODULES=CBI scl-gcc-toolset
endif

GITHUB_REPO=https://github.com/OSGeo/PROJ

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://download.osgeo.org/proj/$(TARBALL); \
	tar xvfz $(TARBALL)

ifeq ($(VERSION_X),9)
$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(BUILD_PATH)/build"
	cd "$(BUILD_PATH)/build"; \
	module --force purge; \
	module load $(CONFIG_MODULES); \
	module list; \
	cmake .. -DCMAKE_INSTALL_PREFIX="$(PREFIX)"

$(BUILD_TARGET): $(CONFIG_TARGET)
	cd "$(BUILD_PATH)/build"; \
	module --force purge; \
	module load $(BUILD_MODULES); \
	module list; \
	cmake --build . ; \
	ctest &> check.log

$(INSTALL_TARGET): $(BUILD_TARGET)
	cd "$(BUILD_PATH)/build"; \
	module --force purge; \
	module load $(BUILD_MODULES); \
	module list; \
	cmake --build . --target install
else
$(BUILD_TARGET): $(CONFIG_TARGET)
	cd $(BUILD_PATH); \
	module --force purge; \
	module load $(BUILD_MODULES); \
	module list; \
	make check &> check.log
endif


#post_build: $(BUILD_PATH)/check.log

#post_install:
#	cp "$(BUILD_PATH)/config.log" "$(PREFIX)"
#	cp "$(BUILD_PATH)/check.log" "$(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
