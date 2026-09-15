NAME=libwebp
VERSION=1.6.0
DOWNLOAD_TARGET_FILE=configure
CONFIG_TARGET_FILE=config.log
## Built last of the libraries, so it also asserts that libwebpmux exists,
## which is what R packages such as 'ragg' link against
BUILD_TARGET_FILE=src/mux/libwebpmux.la
INSTALL_TARGET_FILE=lib/pkgconfig/libwebpmux.pc
