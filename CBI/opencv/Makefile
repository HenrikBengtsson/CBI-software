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
	tar xvfz $(TARBALL); \
	curl -L -o contrib_$(TARBALL) https://github.com/opencv/opencv_contrib/archive/refs/tags/$(VERSION).tar.gz; \
	tar xvfz contrib_$(TARBALL)

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(BUILD_PATH)/build"
	cd "$(BUILD_PATH)/build"; \
	module purge; \
	module try-load $(CONFIG_MODULES); \
	cmake .. -DCMAKE_INSTALL_PREFIX="$(PREFIX)" -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DBUILD_opencv_python2=OFF -DBUILD_opencv_python3=OFF -DCMAKE_INSTALL_LIBDIR=lib64 -DOPENCV_GENERATE_PKGCONFIG=ON -DBUILD_opencv_gapi=OFF -DCMAKE_SKIP_INSTALL_RPATH=ON -DOPENCV_EXTRA_MODULES_PATH="$(BUILD_HOME)/opencv_contrib-$(VERSION)/modules"

$(BUILD_TARGET): $(CONFIG_TARGET)
	cd "$(BUILD_PATH)/build"; \
	module purge; \
	module try-load $(BUILD_MODULES); \
	cmake --build . --parallel 4

$(INSTALL_TARGET): $(BUILD_TARGET)
	cd "$(BUILD_PATH)/build"; \
	module purge; \
	module try-load $(BUILD_MODULES); \
	cmake --build . --target install

BUILD_MODULES=$(CONFIG_MODULES)
