include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/protocolbuffers/protobuf
TARBALL=$(NAME)-$(VERSION).tar.gz

ABSEIL_GITHUB_REPO=https://github.com/abseil/abseil-cpp
ABSEIL_TARBALL=abseil-cpp-$(ABSEIL_VERSION).tar.gz
## Where the abseil source is unpacked.  This is also where protobuf's own
## Bazel build expects it, which makes the layout self-explanatory, but CMake
## does not look here on its own -- it is pointed at it explicitly below.
ABSEIL_PATH=$(BUILD_PATH)/third_party/abseil-cpp

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
## Two tarballs: protobuf itself, plus the pinned abseil (see config.mk).
## Note the 'protobuf-<version>.tar.gz' release asset, not the GitHub
## auto-generated source archive -- only the former carries the CMake build.
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar xf $(TARBALL); \
	curl -L -o $(ABSEIL_TARBALL) $(ABSEIL_GITHUB_REPO)/archive/refs/tags/$(ABSEIL_VERSION).tar.gz; \
	mkdir -p $(ABSEIL_PATH); \
	tar xf $(ABSEIL_TARBALL) -C $(ABSEIL_PATH) --strip-components=1

## -DFETCHCONTENT_SOURCE_DIR_ABSL makes FetchContent use the tarball unpacked
## above instead of cloning; -Dprotobuf_FORCE_FETCH_DEPENDENCIES=ON skips the
## 'find_package(absl)' that runs first, so a stray system abseil can never be
## picked up silently.  Between them the configure step needs no network and
## always resolves to the pinned version.  Do NOT set
## protobuf_LOCAL_DEPENDENCIES_ONLY: it disables the FetchContent branch
## altogether, and configure then dies with "Cannot find abseil-cpp".
##
## -DCMAKE_INSTALL_LIBDIR=lib overrides GNUInstallDirs, which would otherwise
## pick lib64 on x86_64 and leave module.lua.tmpl guessing.
## -Dprotobuf_BUILD_SHARED_LIBS=ON is what makes this the equivalent of the
## distributions' 'protobuf-devel'; the default is static-only.
$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(BUILD_PATH)/build
	cd $(BUILD_PATH)/build; \
	module --force purge; \
	module load $(CONFIG_MODULES); \
	module list; \
	cmake .. \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DCMAKE_INSTALL_PREFIX="$(PREFIX)" \
	  -DCMAKE_INSTALL_LIBDIR=lib \
	  -DCMAKE_CXX_STANDARD=17 \
	  -DCMAKE_SKIP_INSTALL_RPATH=ON \
	  -DFETCHCONTENT_SOURCE_DIR_ABSL="$(ABSEIL_PATH)" \
	  -Dprotobuf_FORCE_FETCH_DEPENDENCIES=ON \
	  -Dprotobuf_BUILD_SHARED_LIBS=ON \
	  -Dprotobuf_BUILD_LIBPROTOC=ON \
	  -Dprotobuf_BUILD_TESTS=OFF \
	  -Dprotobuf_BUILD_EXAMPLES=OFF

$(BUILD_TARGET): $(CONFIG_TARGET)
	cd $(BUILD_PATH)/build; \
	module --force purge; \
	module load $(BUILD_MODULES); \
	cmake --build . --parallel 4

$(INSTALL_TARGET): $(BUILD_TARGET)
	make --quiet assert_version
	make --quiet pre_install
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH)/build; \
	module --force purge; \
	module load $(INSTALL_MODULES); \
	cmake --build . --target install
	make --quiet post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://api.github.com/repos/protocolbuffers/protobuf/releases/latest | jq -r .tag_name | sed 's/^v//'

## The abseil version protobuf pins for this release; compare against
## ABSEIL_VERSION in config.mk after bumping VERSION.
available-abseil-version:
	@sed -n 's/^set(abseil-cpp-version "\(.*\)")$$/\1/p' $(BUILD_PATH)/cmake/dependencies.cmake
