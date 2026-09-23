include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/uxlfoundation/oneTBB
TARBALL=oneTBB-$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -o $(TARBALL) $(GITHUB_REPO)/archive/refs/tags/v$(VERSION).tar.gz; \
	tar xvfz $(TARBALL); \
	mv "oneTBB-$(VERSION)" "$(NAME)-$(VERSION)"

## -DCMAKE_INSTALL_LIBDIR=lib overrides GNUInstallDirs (which would otherwise
## pick lib64 on x86_64) so module.lua.tmpl doesn't have to guess.
## -DTBB_TEST=OFF / -DTBB_EXAMPLES=OFF skip oneTBB's own test/example builds,
## which pull in extra build time and, for TBB_TEST, gtest.
## -DTBB_STRICT=OFF disables -Werror; without it, GCC13's stricter warnings
## (e.g. deprecated std::iterator use elsewhere in the tree) can turn into
## hard build failures.
## -DCMAKE_SKIP_INSTALL_RPATH=ON: see skill guidance on RPATH mitigation --
## consumers get libtbb via LD_LIBRARY_PATH from this module's module.lua,
## not a baked-in rpath.
$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(BUILD_PATH)/build"
	cd "$(BUILD_PATH)/build"; \
	module --force purge; \
	module try-load $(CONFIG_MODULES); \
	module list; \
	cmake .. \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DCMAKE_INSTALL_PREFIX="$(PREFIX)" \
	  -DCMAKE_INSTALL_LIBDIR=lib \
	  -DCMAKE_CXX_STANDARD=17 \
	  -DCMAKE_SKIP_INSTALL_RPATH=ON \
	  -DBUILD_SHARED_LIBS=ON \
	  -DTBB_TEST=OFF \
	  -DTBB_EXAMPLES=OFF \
	  -DTBB_STRICT=OFF

$(BUILD_TARGET): $(CONFIG_TARGET)
	cd "$(BUILD_PATH)/build"; \
	module --force purge; \
	module try-load $(BUILD_MODULES); \
	cmake --build . --parallel 4

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cd "$(BUILD_PATH)/build"; \
	module --force purge; \
	module try-load $(BUILD_MODULES); \
	cmake --build . --target install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://api.github.com/repos/uxlfoundation/oneTBB/releases/latest | jq -r .tag_name | sed 's/^v//'
