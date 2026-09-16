NAME=librsvg
VERSION=2.56.5
MAJOR_VERSION=$(shell echo $(VERSION) | cut -d. -f1,2)
TARBALL=$(NAME)-$(VERSION).tar.xz
DOWNLOAD_FILE=configure
BUILD_TARGET_FILE=rsvg-convert
INSTALL_TARGET_FILE=bin/rsvg-convert

CONFIG_MODULES=CBI scl-gcc-toolset rust

# librsvg needs glib, gdk-pixbuf, cairo, pango.
# PKG_CONFIG_PATH is automatically inherited from modules if we needed them, but we assume they are system packages.
