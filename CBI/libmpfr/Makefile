include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).tar.gz

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://www.mpfr.org/mpfr-$(VERSION)/$(TARBALL); \
	tar xvfz $(TARBALL)

available-version:
	@curl -s https://www.mpfr.org/mpfr-current/ | grep -o 'mpfr-[0-9]\+\.[0-9]\+\.[0-9]\+\.tar\.gz' | head -1 | sed 's/mpfr-//;s/.tar.gz//'

post_config:
	sed -i 's|^hardcode_libdir_flag_spec=.*|hardcode_libdir_flag_spec=""|g' $(BUILD_PATH)/libtool || true
	sed -i 's|^runpath_var=LD_RUN_PATH|runpath_var=DIE_RPATH_DIE|g' $(BUILD_PATH)/libtool || true

post_install:
	find $(PREFIX) -type f -name "*.la" -delete
