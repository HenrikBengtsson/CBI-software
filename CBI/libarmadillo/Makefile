include config.mk
include ../utils.mk

TARBALL=armadillo-$(VERSION).tar.xz

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://sourceforge.net/projects/arma/files/$(TARBALL); \
	tar xf $(TARBALL); \
	rm -rf $(NAME)-$(VERSION); \
	mv armadillo-$(VERSION) $(NAME)-$(VERSION)

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(BUILD_PATH)/build"
	cd "$(BUILD_PATH)/build"; \
	module purge; \
	module load $(CONFIG_MODULES); \
	cmake .. -DCMAKE_INSTALL_PREFIX="$(PREFIX)"

$(BUILD_TARGET): $(CONFIG_TARGET)
	cd "$(BUILD_PATH)/build"; \
	module purge; \
	module load $(BUILD_MODULES); \
	cmake --build .

$(INSTALL_TARGET): $(BUILD_TARGET)
	make --quiet pre_install
	mkdir -p $(PREFIX)
	module --force purge; \
	module try-load $(INSTALL_MODULES); \
	cd "$(BUILD_PATH)/build"; \
	module purge; \
	module load $(BUILD_MODULES); \
	cmake --build . --target install
	make --quiet post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent -L "https://arma.sourceforge.net/download.html" | grep -o 'armadillo-[0-9\.]*\.tar\.xz' | head -n 1 | sed 's/armadillo-//;s/\.tar\.xz//'
