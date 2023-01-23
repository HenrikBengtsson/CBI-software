include config.mk
include ../utils.mk

TARBALL=$(VERSION).tar.gz
GITHUB_REPO=https://github.com/redis/redis

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/archive/refs/tags/$(TARBALL); \
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

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -E "^location:" | sed -E 's/.*(v|\/)//'
