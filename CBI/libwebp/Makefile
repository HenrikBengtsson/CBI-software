include config.mk
include ../utils.mk

## libwebpmux and libwebpdemux are enabled by default upstream, but 'ragg'
## and other consumers need them, so ask for them explicitly rather than
## rely on that default
CONFIG_OPTS=--enable-shared --disable-static --disable-dependency-tracking \
            --enable-libwebpmux --enable-libwebpdemux

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://storage.googleapis.com/downloads.webmproject.org/releases/webp/$(TARBALL); \
	tar xf $(TARBALL)

## Upstream publishes tarballs on the WebM download server and only tags on
## GitHub - there are no GitHub releases - so 'available-version-github'
## does not apply here
available-version:
	@curl --silent https://api.github.com/repos/webmproject/libwebp/tags | grep '"name"' | sed -E 's/.*"v([0-9.]+)".*/\1/' | grep -E "^[0-9.]+$$" | sort -V -r | head -n 1
