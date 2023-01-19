include config.mk
include ../utils.mk

TARBALL=$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/redis/redis/archive/refs/tags/$(TARBALL); \
	tar xf $(TARBALL)

$(BUILD_PATH)/src/make_check.log:
	module purge; \
	cd "$(BUILD_PATH)/src/"; \
	make check > "$@.tmp"
	mv "$@.tmp" "$@"

post_build: $(BUILD_PATH)/src/make_check.log

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	module purge; \
	cd "$(BUILD_PATH)"; \
	true #make
	make post_build

post_install:
	cp "$(BUILD_PATH)/src/make_check.log" "$(PREFIX)"

$(INSTALL_TARGET): $(BUILD_TARGET)
	module purge; \
	cd "$(BUILD_PATH)"; \
	make PREFIX="$(PREFIX)" install
	make post_install


