include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O https://cran.r-project.org/src/base/R-3/$(TARBALL); \
	tar xvfz $(TARBALL)

post_install_software:
	## Prevent package installations/updates in system library
	chmod -R ugo-w $(PREFIX)/lib64/R/library


## ----------------------------------------------------------
## MODULE
## ----------------------------------------------------------
