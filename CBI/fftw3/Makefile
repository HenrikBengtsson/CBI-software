include config.mk
include ../utils.mk

TARBALL=fftw-$(VERSION).tar.gz

BUILD_OPTS=LDFLAGS="" LD_RUN_PATH=""

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://www.fftw.org/$(TARBALL); \
	tar xvfz $(TARBALL); \
	mv fftw-$(VERSION) fftw3-$(VERSION)

post_config:
	sed -i 's|^hardcode_libdir_flag_spec=.*|hardcode_libdir_flag_spec=""|g' $(BUILD_PATH)/libtool || true
	sed -i 's|^runpath_var=LD_RUN_PATH|runpath_var=DIE_RPATH_DIE|g' $(BUILD_PATH)/libtool || true

post_install:
	find $(PREFIX)/lib -name "*.la" -delete || true

available-version:
	@curl --silent https://www.fftw.org/download.html | grep -Eo 'fftw-[0-9]+\.[0-9]+\.[0-9]+' | head -1 | sed 's/fftw-//'
