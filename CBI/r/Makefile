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

post_build:
	cd $(BUILD_PATH); \
	R_LIBS_USER=dummy make check &> make-check.log

post_install:
	## Prevent package installations/updates in system library
	chmod -R ugo-w $(PREFIX)/lib64/R/library
	## Save log files
	cp $(BUILD_PATH)/config.log $(PREFIX)/
	cp $(BUILD_PATH)/make-check.log $(PREFIX)/
	grep -A 28 -F "R is now configured" $(BUILD_PATH)/config.log > $(PREFIX)/config.log.summary
