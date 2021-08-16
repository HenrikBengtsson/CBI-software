include config.mk

## Special cases (must come before including utils.mk)

## Building alpha of beta version?
ifeq ($(findstring alpha,$(VERSION)),alpha)
	BUILD_NAME=R-alpha
else ifeq ($(findstring beta,$(VERSION)),beta)
	BUILD_NAME=R-beta
endif


## Build using specific GCC version?
ifneq ($(GCC_VERSION),)
	CONFIG_MODULES=CBI scl-devtoolset/$(GCC_VERSION)
	BUILD_MODULES=CBI scl-devtoolset/$(GCC_VERSION)
	BUILD_SUFFIX=-gcc$(GCC_VERSION)
	PREFIX=$(SOFTWARE_HOME)/$(NAME)-$(VERSION)$(BUILD_SUFFIX)
	TARBALL=$(NAME)-$(VERSION).tar.gz        
endif
MODULE_TARGET_DEFAULT=$(MODULE_HOME)/$(MODULE_NAME)/$(VERSION).lua

include ../utils.mk

ifeq ($(findstring alpha,$(VERSION)),alpha)
	TARBALL=R-latest.tar.gz
	DOWNLOAD_URL_PATH=https://cran.r-project.org/src/base-prerelease
else ifeq ($(findstring beta,$(VERSION)),beta)
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
	@echo "GCC_VERSION=$(GCC_VERSION)"
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

$(MODULE_TARGET): module.lua.tmpl
	mkdir -p "$(@D)"
	cp "$<" "$@"
	sed -i 's/myModuleVersion[(][)]/"$(MODULE_VERSION)"/' "$@"
	if [[ ! -f "$(MODULE_TARGET_DEFAULT)" ]]; then ln -s "$@" "$(MODULE_TARGET_DEFAULT)"; fi
	module --ignore-cache show $(MODULE_NAME_VERSION)
	module load $(MODULE_NAME_VERSION)
	module unload $(MODULE_NAME_VERSION)
