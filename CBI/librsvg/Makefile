include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
CONFIG_OPTS=--enable-shared --disable-static --disable-dependency-tracking --disable-pixbuf-loader

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://download.gnome.org/sources/librsvg/$(MAJOR_VERSION)/$(TARBALL); \
	tar xf $(TARBALL)

available-version:
	@curl -sL "https://download.gnome.org/sources/librsvg/$(MAJOR_VERSION)/" | grep -o 'librsvg-$(MAJOR_VERSION).[0-9]\+.tar.xz' | sort -V | tail -n 1 | sed 's/librsvg-//' | sed 's/.tar.xz//'
