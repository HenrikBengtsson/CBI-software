include config.mk

## Special cases (must come before including utils.mk)

## Building alpha of beta version?
ifeq ($(findstring alpha,$(VERSION)),alpha)
	BUILD_NAME=R-alpha
else ifeq ($(findstring beta,$(VERSION)),beta)
	BUILD_NAME=R-alpha
endif

## Build using specific GCC version?
ifeq ($(findstring gcc4,$(VERSION)),gcc4)
	CONFIG_MODULES=
	BUILD_MODULES=
	BUILD_NAME:=$(BUILD_NAME)-gcc4
else ifeq ($(findstring gcc7,$(VERSION)),gcc7)
	CONFIG_MODULES=CBI scl-devtoolset/7
	BUILD_MODULES=CBI scl-devtoolset/7
	BUILD_NAME:=$(BUILD_NAME)-gcc7
else ifeq ($(findstring gcc9,$(VERSION)),gcc8)
	CONFIG_MODULES=CBI scl-devtoolset/8
	BUILD_MODULES=CBI scl-devtoolset/8
	BUILD_NAME:=$(BUILD_NAME)-gcc8
else ifeq ($(findstring gcc9,$(VERSION)),gcc9)
	CONFIG_MODULES=CBI scl-devtoolset/9
	BUILD_MODULES=CBI scl-devtoolset/9
	BUILD_NAME:=$(BUILD_NAME)-gcc9
endif


include ../utils.mk

ifeq ($(findstring alpha,$(VERSION)),alpha)
	TARBALL=R-latest.tar.gz
	DOWNLOAD_URL_PATH=https://cran.r-project.org/src/base-prerelease
else
	DOWNLOAD_URL_PATH=https://cran.r-project.org/src/base/R-$(VERSION_X)
endif

DOWNLOAD_URL=$(DOWNLOAD_URL_PATH)/$(TARBALL)

debug2: debug
	@echo
	@echo "BUILD_NAME=$(BUILD_NAME)"
	@echo "DOWNLOAD_URL_PATH=$(DOWNLOAD_URL_PATH)"
	@echo "DOWNLOAD_URL=$(DOWNLOAD_URL)"
	@echo "CONFIG_MODULES=$(CONFIG_MODULES)"
	@echo "BUILD_MODULES=$(BUILD_MODULES)"


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)/untar
	cd $(BUILD_HOME); \
	curl -O $(DOWNLOAD_URL); \
	tar xvfz $(TARBALL) -C untar; \
	mv untar/* $(BUILD_NAME); \
	rmdir untar

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
