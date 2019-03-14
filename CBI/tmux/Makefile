#' Example:
#' make VERSION=2.6

include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/tmux/tmux/releases/download/$(VERSION)/$(TARBALL); \
	tar xvfz $(TARBALL)


## ----------------------------------------------------------
## MODULE
## ----------------------------------------------------------
