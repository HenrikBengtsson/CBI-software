include config.mk
include ../version.mk

## Special cases (must come before including utils.mk)

## Building alpha, beta, or release-candidate version?
ifeq ($(findstring alpha,$(VERSION)),alpha)
	BUILD_NAME=R-alpha
else ifeq ($(findstring beta,$(VERSION)),beta)
	BUILD_NAME=R-beta
else ifeq ($(findstring rc,$(VERSION)),rc)
	BUILD_NAME=R-rc
endif

## Use modern GCC and Java versions?
GCC_VERSION=10
ifeq ($(VERSION_X),1)
    GCC_VERSION=
else ifeq ($(VERSION_X),2)
    GCC_VERSION=
else ifeq ($(VERSION_X),3)
    GCC_VERSION=
else ifeq ($(VERSION_X),4)
    ifeq ($(VERSION_X_Y),4.0)
    else ifeq ($(VERSION_X_Y),4.1)
        GCC_VERSION=8
    endif
endif

## Check if CBI scl-devtoolset modules are available
#module load CBI
#module spider scl-devtoolset => exit code 0, if exists
#module spider scl-devtoolset/GCC_VERSION => exit code 0, if exists
#
## TODO: Query 'gcc --version' for GCC_VERSION
#gcc --version | head -1 | sed 's/.* //' | sed 's/[.].*//'


## Build using specific GCC version?
ifneq ($(GCC_VERSION),)
	CONFIG_MODULES=CBI scl-devtoolset/$(GCC_VERSION)
	BUILD_MODULES=CBI scl-devtoolset/$(GCC_VERSION)
	BUILD_SUFFIX=-gcc$(GCC_VERSION)
	PREFIX=$(SOFTWARE_HOME)/$(NAME)-$(VERSION)$(BUILD_SUFFIX)
	MODULE_VERSION=$(VERSION)$(BUILD_SUFFIX)
endif
MODULE_TARGET_DEFAULT=$(MODULE_HOME)/$(MODULE_NAME)/$(VERSION).lua

include ../utils.mk

## Make TARBALL ignore BUILD_SUFFIX
TARBALL=$(NAME)-$(VERSION).tar.gz
ifeq ($(findstring alpha,$(VERSION)),alpha)
	TARBALL=R-latest.tar.gz
	DOWNLOAD_URL_PATH=https://cran.r-project.org/src/base-prerelease
else ifeq ($(findstring beta,$(VERSION)),beta)
	TARBALL=R-latest.tar.gz
	DOWNLOAD_URL_PATH=https://cran.r-project.org/src/base-prerelease
else ifeq ($(findstring rc,$(VERSION)),rc)
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
	@echo "OPENJDK_VERSION=$(OPENJDK_VERSION)"
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
	chmod -R u+w $(PREFIX)/lib*/R/{bin,etc}
	chmod u+w $(PREFIX)/*
	if module load openjdk/$(OPENJDK_VERSION); then \
	    [[ -n $${JAVA_HOME} ]] || { echo >&2 "ERROR: JAVA_HOME not set"; exit 1; } \
	else \
	    >&2 echo "WARNING: Failed to load module 'openjdk/$(OPENJDK_VERSION)'; leaving it to 'R CMD javareconf' to locate a proper Java version (JAVA_HOME)"; \
	fi; \
	JAVA_VERSION=$$(java -version 2>&1 | head -1 | sed -E 's/.*"(.*)".*/\1/'); \
	JAVAC_VERSION=$$(javac -version | head -1 | sed 's/.* //');                \
	JAVA_VERSION_XY=$$(echo "$${JAVA_VERSION:?}" | sed 's/[.][^.]*$$//');      \
	JAVAC_VERSION_XY=$$(echo "$${JAVAC_VERSION:?}" | sed 's/[.][^.]*$$//');    \
	echo "JAVA_VERSION_XY=$${JAVA_VERSION_XY:?}";                              \
	echo "JAVAC_VERSION_XY=$${JAVAC_VERSION_XY:?}";                            \
	if [[ "$${JAVA_VERSION_XY:?}" != "$${JAVAC_VERSION_XY:?}" ]]; then         \
	    >&2 echo "ERROR: java and javac are of different versions: $${JAVA_VERSION} != $${JAVAC_VERSION}"; \
	    exit 1;                                                                \
        fi;                                                                        \
	mkdir -p "$(BUILD_PATH)";                                                   \
	if ! $(PREFIX)/bin/R CMD javareconf &> "$(BUILD_PATH)/javareconf.log"; then \
	    >&2 echo "ERROR: R CMD javareconf failed;"; \
	    >&2 cat "$(BUILD_PATH)/javareconf.log"; \
	    exit 1; \
	fi
	cat "$(BUILD_PATH)/javareconf.log"

	## Save log files
	cp "$(BUILD_PATH)/javareconf.log" $(PREFIX)/
	cp "$(BUILD_PATH)/config.log" $(PREFIX)/
	cp "$(BUILD_PATH)/make-check.log" $(PREFIX)/
	grep -A 28 -F "R is now configured" "$(BUILD_PATH)/config.log" > "$(PREFIX)/config.log.summary"

	make write_protect_install

$(MODULE_TARGET): module.lua.tmpl
	mkdir -p "$(@D)"
	if [[ -f "$@" ]]; then chmod u+w "$@"; fi
	cp "$<" "$@"
	sed -i 's/myModuleVersion[(][)]/"$(MODULE_VERSION)"/' "$@"
	if [[ ! -f "$(MODULE_TARGET_DEFAULT)" ]]; then ln -s "$@" "$(MODULE_TARGET_DEFAULT)"; fi
	make write_protect_module
	module --ignore-cache show $(MODULE_NAME_VERSION)
	module load $(MODULE_NAME_VERSION)
	module unload $(MODULE_NAME_VERSION)
