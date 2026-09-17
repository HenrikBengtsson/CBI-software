unexport LD_RUN_PATH
unexport LD_LIBRARY_PATH

include config.mk
include ../utils.mk

TARBALL=$(VERSION).tar.gz

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O "https://github.com/coin-or/Clp/archive/refs/tags/releases/$(TARBALL)"; \
	tar xvfz $(TARBALL); \
	mv $(NAME)-releases-$(VERSION) $(BUILD_NAME)


post_config:
	sed -i 's|^hardcode_libdir_flag_spec=.*|hardcode_libdir_flag_spec=""|g' $(BUILD_PATH)/libtool || true
	sed -i 's|^runpath_var=LD_RUN_PATH|runpath_var=DIE_RPATH_DIE|g' $(BUILD_PATH)/libtool || true

$(BUILD_TARGET): $(CONFIG_TARGET)
	make --quiet post_config
	module --force purge; \
	module try-load $(BUILD_MODULES); \
	cd $(BUILD_PATH); \
	unset LD_RUN_PATH; \
	make $(BUILD_OPTS)
	make --quiet post_build

$(INSTALL_TARGET): $(BUILD_TARGET)
	make --quiet assert_version
	make --quiet pre_install
	mkdir -p $(PREFIX)
	module --force purge; \
	module try-load $(INSTALL_MODULES); \
	cd $(BUILD_PATH); \
	unset LD_RUN_PATH; \
	make --quiet install
	make --quiet post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

post_install:
	find $(PREFIX)/lib -name "*.la" -delete || true
