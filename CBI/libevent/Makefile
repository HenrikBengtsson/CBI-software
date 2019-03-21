#' Example:
#' make VERSION=2.1.8

include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/libevent/libevent/releases/download/release-$(VERSION)-stable/$(TARBALL); \
	tar xvfz $(TARBALL)

## FIXME: This fail on Wynton with:
## [msg] Nameserver 127.0.0.1:51382 has failed: request timed out.
check_software: $(BUILD_TARGET)
	cd $(BUILD_PATH); \
