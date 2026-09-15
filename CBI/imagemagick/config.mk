NAME=imagemagick
VERSION=7.1.2-31
DOWNLOAD_TARGET_FILE=configure
CONFIG_TARGET_FILE=config.log
BUILD_TARGET_FILE=Magick++/lib/libMagick++-$(MAGICK_ABI).la
INSTALL_TARGET_FILE=lib/pkgconfig/Magick++.pc
RECENT_ONLY=true

## ImageMagick names its libraries and *.pc files after the ABI, which is
## determined by the major version, the quantum depth, and whether HDRI is
## enabled, e.g. libMagick++-7.Q16HDRI.so. We pin all three in CONFIG_OPTS
## (see Makefile) so that the built file names are deterministic.
MAGICK_ABI=7.Q16HDRI
