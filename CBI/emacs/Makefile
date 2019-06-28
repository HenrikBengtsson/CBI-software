include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O http://gnu.mirrors.hoobly.com/emacs/$(TARBALL); \
	tar xvfz $(TARBALL)
