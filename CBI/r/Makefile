include config.mk

## Special cases (must come before including utils.mk)
ifeq ($(findstring alpha,$(VERSION)),alpha)
	BUILD_NAME=R-alpha
	TARBALL=R-latest.tar.gz
	DOWNLOAD_URL_PATH=https://cran.r-project.org/src/base-prerelease
	CONFIG_MODULES=CBI scl-devtoolset/7
	BUILD_MODULES=CBI scl-devtoolset/7
endif

include ../utils.mk

ifneq ($(findstring alpha,$(VERSION)),alpha)
	DOWNLOAD_URL_PATH=https://cran.r-project.org/src/base/R-$(VERSION_X)
endif

DOWNLOAD_URL=$(DOWNLOAD_URL_PATH)/$(TARBALL)

debug2: debug
	@echo
	@echo "DOWNLOAD_URL_PATH=$(DOWNLOAD_URL_PATH)"
	@echo "DOWNLOAD_URL=$(DOWNLOAD_URL)"


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O $(DOWNLOAD_URL); \
	tar xvfz $(TARBALL)

post_build:
	cd $(BUILD_PATH); \
	R_LIBS_USER=dummy make check &> make-check.log

post_install:
	## Prevent package installations/updates in system library
	chmod -R ugo-w $(PREFIX)/lib*/R/library
	## Configure R for Java (so that 'rJava' can be installed)
	$(PREFIX)/bin/R CMD javareconf &> "$(BUILD_PATH)/javareconf.log"
	cat "$(BUILD_PATH)/javareconf.log"
	## Save log files
	cp "$(BUILD_PATH)/config.log" $(PREFIX)/
	cp "$(BUILD_PATH)/make-check.log" $(PREFIX)/
	cp "$(BUILD_PATH)/javareconf.log" $(PREFIX)/
	grep -A 28 -F "R is now configured" "$(BUILD_PATH)/config.log" > "$(PREFIX)/config.log.summary"
