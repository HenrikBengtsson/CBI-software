include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/opencv/opencv
TARBALL=$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -o $(TARBALL) $(GITHUB_REPO)/archive/refs/tags/$(VERSION).tar.gz; \
	tar xvfz $(TARBALL)

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(BUILD_PATH)/build"
	cd "$(BUILD_PATH)/build"; \
	module purge; \
	module load $(CONFIG_MODULES); \
	cmake .. -DCMAKE_INSTALL_PREFIX="$(PREFIX)" -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DBUILD_opencv_python2=OFF -DBUILD_opencv_python3=OFF

$(BUILD_TARGET): $(CONFIG_TARGET)
	cd "$(BUILD_PATH)/build"; \
	module purge; \
	module load $(BUILD_MODULES); \
	cmake --build . --parallel 4

$(INSTALL_TARGET): $(BUILD_TARGET)
	cd "$(BUILD_PATH)/build"; \
	module purge; \
	module load $(BUILD_MODULES); \
	cmake --build . --target install

BUILD_MODULES=$(CONFIG_MODULES)
