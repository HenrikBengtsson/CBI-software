export LD_RUN_PATH=
export LD_LIBRARY_PATH=

include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).tar.gz

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://ftp.gnu.org/gnu/glpk/$(TARBALL); \
	tar xvfz $(TARBALL)

available-version:
	@curl -s https://ftp.gnu.org/gnu/glpk/ | grep -o 'glpk-[0-9.]*\.tar\.gz' | sort -V | tail -n 1 | sed -E 's/glpk-(.*)\.tar\.gz/\1/'

BUILD_OPTS=LDFLAGS="" LD_RUN_PATH=""

post_config:
	sed -i 's|^hardcode_libdir_flag_spec=.*|hardcode_libdir_flag_spec=""|g' $(BUILD_PATH)/libtool || true
	sed -i 's|^runpath_var=LD_RUN_PATH|runpath_var=DIE_RPATH_DIE|g' $(BUILD_PATH)/libtool || true

post_install:
	find $(PREFIX)/lib -name "*.la" -delete || true
