include config.mk
include ../utils.mk

## PROJ (>= 6.3.0) requires sqlite3 (>= 3.11)
ifeq ($(VERSION_X_Y),6.3)
else ifeq ($(VERSION_X),7)
    CONFIG_MODULES=CBI sqlite
else ifeq ($(VERSION_X),8)
    CONFIG_MODULES=CBI sqlite
else ifeq ($(VERSION_X),9)
    CONFIG_MODULES=CBI sqlite
    $(error Not yet supported: $NAME >= 9 requires CMake)
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

$(BUILD_PATH)/check.log:
	cd $(BUILD_PATH); \
	module --force purge; \
	module load $(BUILD_MODULES); \
	module list; \
	make check &> check.log

post_build: $(BUILD_PATH)/check.log

post_install:
	cp "$(BUILD_PATH)/config.log" "$(PREFIX)"
	cp "$(BUILD_PATH)/check.log" "$(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
