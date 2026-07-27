include config.mk
include ../utils.mk

ARCH=x86_64-unknown-linux-musl
TARBALL=$(NAME)-v$(VERSION)-$(ARCH).tar.gz
GITHUB_REPO=https://github.com/ImageMagick/ImageMagick

ARCH=x86_64
FILENAME=$(VERSION)/ImageMagick-$(VERSION)-gcc-$(ARCH).AppImage

## 2026-07-27: Rocky 9
## magick: /lib64/libm.so.6: version `GLIBC_2.35' not found
## => We need to build ImageMagick from source

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -o magick https://github.com/ImageMagick/ImageMagick/releases/download/$(FILENAME)
#	curl -L -O https://imagemagick.org/archive/binaries/magick

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -pR $(BUILD_PATH) $(PREFIX)/..
	chmod ugo+x $(PREFIX)/magick
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

