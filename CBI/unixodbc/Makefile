## Always clear LD_RUN_PATH
export LD_RUN_PATH=

include config.mk
include ../utils.mk

DOWNLOAD_URL=ftp://ftp.unixodbc.org/pub/unixODBC

## --enable-drivers=no (default, pinned here so a future release cannot
## flip it) keeps the bundled sample drivers out
##
## --without-pth: GNU Pth is user-space threading, irrelevant for us
##
## --sysconfdir=/etc rather than the autotools default of $PREFIX/etc.
CONFIG_OPTS=--enable-drivers=no --without-pth --sysconfdir=/etc \
            --enable-threads=yes --enable-iconv=yes \
            --disable-static --disable-dependency-tracking

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O $(DOWNLOAD_URL)/$(TARBALL); \
	tar xf $(TARBALL)

## Standard libtool rpath removal
post_config:
	sed -i 's|^hardcode_libdir_flag_spec=.*|hardcode_libdir_flag_spec=""|g' $(BUILD_PATH)/libtool || true
	sed -i 's|^runpath_var=LD_RUN_PATH|runpath_var=DIE_RPATH_DIE|g' $(BUILD_PATH)/libtool || true

post_install:
	find $(PREFIX)/lib -name "*.la" -delete || true
	make --quiet write_protect_install

available-version:
	@curl --silent https://api.github.com/repos/lurcher/unixODBC/releases/latest | jq -r .tag_name | sed 's/^v//'
