include config.mk
include ../utils.mk

TARBALL=ImageMagick-$(VERSION).tar.gz
GITHUB_REPO=https://github.com/ImageMagick/ImageMagick

## --with-quantum-depth and --enable-hdri decide the ABI name; keep them in
## sync with MAGICK_ABI in config.mk.
CONFIG_OPTS=--enable-shared --disable-static --disable-dependency-tracking \
            --with-magick-plus-plus=yes \
            --with-quantum-depth=16 --enable-hdri \
            --without-x

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://download.imagemagick.org/archive/releases/$(TARBALL); \
	tar xf $(TARBALL); \
	mv ImageMagick-$(VERSION) $(NAME)-$(VERSION)


## ImageMagick's configure quietly drops any delegate whose development
## headers are missing, which would yield an ImageMagick -- and hence an R
## 'magick' -- that cannot read PNG, JPEG, or TIFF.  Fail here rather than
## after a full build.
REQUIRED_DELEGATES=PNG JPEG TIFF ZLIB
post_config:
	missing=; \
	for d in $(REQUIRED_DELEGATES); do \
	    if ! grep -q -E "^#define $${d}_DELEGATE" "$(BUILD_PATH)/config/config.h"; then \
	        missing="$${missing} $${d}"; \
	    fi; \
	done; \
	if [[ -n "$${missing}" ]]; then \
	    mv "$(CONFIG_TARGET)" "$(CONFIG_TARGET).fail"; \
	    >&2 echo "ERROR: ImageMagick configured without delegate(s):$${missing}"; \
	    >&2 echo "ERROR: Install the matching development headers (deb: libpng-dev libjpeg-dev libtiff-dev zlib1g-dev; rpm: libpng-devel libjpeg-turbo-devel libtiff-devel zlib-devel) and re-run 'make config'"; \
	    exit 1; \
	fi
	@echo "All required delegates present: $(REQUIRED_DELEGATES)"

## ImageMagick installs ABI-versioned pkg-config files, e.g.
## 'Magick++-7.Q16HDRI.pc'.  Build systems generally look for the
## unversioned name instead -- R's 'magick' package, for one, does
## `pkg-config --exists Magick++` -- so make sure those aliases exist.
post_install:
	cd $(PREFIX)/lib/pkgconfig; \
	for abi in *-$(MAGICK_ABI).pc; do \
	    if [[ ! -e "$${abi}" ]]; then continue; fi; \
	    generic="$${abi%-$(MAGICK_ABI).pc}.pc"; \
	    if [[ ! -e "$${generic}" ]]; then ln -s "$${abi}" "$${generic}"; fi; \
	done; \
	ls -la
	make --quiet write_protect_install
