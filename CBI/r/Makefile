include config.mk
include ../version.mk
include ../sysinfo.mk

## Special cases (must come before including utils.mk)

## Use modern GCC and Java versions?
GCC_MODULE=
GCC_VERSION=10
ifeq ($(LINUX_NAME),Ubuntu)
    ifeq ($(LINUX_VERSION),22.04)
        GCC_VERSION=11
    endif
else ifeq ($(LINUX_NAME),CentOS Linux)
    GCC_MODULE=scl-devtoolset
else ifeq ($(LINUX_NAME),Rocky Linux)
    GCC_MODULE=scl-gcc-toolset
endif

ifeq ($(VERSION_X),1)
    GCC_VERSION=
else ifeq ($(VERSION_X),2)
    GCC_VERSION=
else ifeq ($(VERSION_X),3)
    GCC_VERSION=
else ifeq ($(VERSION_X),4)
    ifeq ($(VERSION_X_Y),4.0)
        GCC_VERSION=
    else ifeq ($(VERSION_X_Y),4.1)
        GCC_VERSION=
        ifeq ($(LINUX_NAME),CentOS Linux)
            GCC_VERSION=8
        endif
    endif
endif


## Building alpha, beta, or release-candidate version?
ifeq ($(findstring alpha,$(VERSION)),alpha)
	BUILD_NAME=R-alpha
else ifeq ($(findstring beta,$(VERSION)),beta)
	BUILD_NAME=R-beta
else ifeq ($(findstring rc,$(VERSION)),rc)
	BUILD_NAME=R-rc
endif

## Check if CBI $(GCC_MODULE) modules are available
#module load CBI
#module spider $(GCC_MODULE) => exit code 0, if exists
#module spider $(GCC_MODULE)/GCC_VERSION => exit code 0, if exists

## Build using specific GCC version?
ifneq ($(GCC_VERSION),)
	ifneq ($(GCC_MODULE),)
		CONFIG_MODULES=CBI $(GCC_MODULE)/$(GCC_VERSION)
		BUILD_MODULES=CBI $(GCC_MODULE)/$(GCC_VERSION)
	endif
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
	@echo "GCC_MODULE=$(GCC_MODULE)"
	@echo "OPENJDK_VERSION=$(OPENJDK_VERSION)"
	@echo "CONFIG_MODULES=$(CONFIG_MODULES)"
	@echo "BUILD_MODULES=$(BUILD_MODULES)"


assert_gcc_version:
	@curr_version=$$(module --force purge; module try-load $(CONFIG_MODULES) && gcc --version | head -1 | sed 's/.* //' | sed 's/[.].*//'); \
	echo "Requested GCC version: $(GCC_VERSION)"; \
	echo "Provided GCC version: $${curr_version}"; \
	[[ "$(GCC_VERSION)" == "" ]] || [[ $${curr_version} == "$(GCC_VERSION)" ]] || { 2>&1 echo "ERROR: Provided GCC version (v$${curr_version}) not the same as the requested one (v$(GCC_VERSION))"; exit 1; }

assert_java_version:
	module --force purge; \
	if module load openjdk/$(OPENJDK_VERSION) 2> /dev/null; then \
	    [[ -n $${JAVA_HOME} ]] || { echo >&2 "ERROR: JAVA_HOME not set"; exit 1; } \
	else \
	    >&2 echo "WARNING: Failed to load module 'openjdk/$(OPENJDK_VERSION)'; leaving it to 'R CMD javareconf' to locate a proper Java version (JAVA_HOME)"; \
	fi; \
	JAVA_VERSION=$$(java   -version 2>&1 | head -1 | sed -E 's/.*"(.*)".*/\1/'); \
	JAVAC_VERSION=$$(javac -version 2>&1 | head -1 | sed 's/.* //');             \
	JAVA_VERSION_XY=$$(echo "$${JAVA_VERSION:?}" | sed 's/[.][^.]*$$//');        \
	JAVAC_VERSION_XY=$$(echo "$${JAVAC_VERSION:?}" | sed 's/[.][^.]*$$//');      \
	echo "JAVA_HOME=$${JAVA_HOME}";                                              \
	echo "JAVA_VERSION_XY=$${JAVA_VERSION_XY:?}";                                \
	echo "JAVAC_VERSION_XY=$${JAVAC_VERSION_XY:?}";                              \
	if [[ "$${JAVA_VERSION_XY:?}" != "$${JAVAC_VERSION_XY:?}" ]]; then           \
	    >&2 echo "ERROR: java and javac are of different versions: $${JAVA_VERSION} != $${JAVAC_VERSION}"; \
            if [[ "$(LINUX_NAME)" == "Ubuntu" ]]; then \
              >&2 echo "To fix this on Ubuntu, run:"; \
              >&2 echo "  sudo update-alternatives --config java"; \
              >&2 echo "  sudo update-alternatives --config javac"; \
            fi; \
	    exit 1;                                                                  \
        fi;

assert_config: $(CONFIG_TARGET)
#	## Has C++ compiler
	grep -E "C[+][+]([[:digit:]]+|) compiler:[[:space:]]*g[+][+][[:space:]]+" "$<"

#	## Has C++11 compiler with version
#	## Has C++11 compiler
	if [[ $${VERSION_X} -ge 4 ]] || [[ $${VERSION_X} -ge 3 ]] && [[ $${VERSION_Y} -ge 4 ]]; then \
	    grep -E "C[+][+]([[:digit:]]+|) compiler:[[:space:]]*g[+][+][[:space:]]+-std=gnu[+][+][[:digit:]]+\b" "$<"; \
	    grep -E "C[+][+]([[:digit:]]+|) compiler:[[:space:]]*g[+][+][[:space:]]+-std=gnu[+][+]11\b" "$<"; \
	fi
#	## Has C++14 compiler
#	## Has C++17 compiler
	if [[ $${VERSION_X} -ge 4 ]]; then \
	    grep -E "C[+][+]([[:digit:]]+|) compiler:[[:space:]]*g[+][+][[:space:]]+-std=gnu[+][+]14\b" "$<"; \
	    grep -E "C[+][+]([[:digit:]]+|) compiler:[[:space:]]*g[+][+][[:space:]]+-std=gnu[+][+]17\b" "$<"; \
	fi

	grep -E "Interfaces supported:.*\bX11\b" "$<"
	if [[ $${VERSION_X} -ge 4 ]]; then \
	    grep -E "Interfaces supported:.*\btcltk\b" "$<"; \
	fi

	grep -E "External libraries:.*\breadline\b" "$<"
	if [[ $${VERSION_X} -ge 4 ]]; then \
	    grep -E "External libraries:.*\bpcre2\b" "$<"; \
	    grep -E "External libraries:.*\bcurl\b" "$<"; \
	    grep -E "Additional capabilities:.*\bICU\b" "$<"; \
	fi

	grep -E "Additional capabilities:.*\bPNG\b" "$<"
	grep -E "Additional capabilities:.*\bJPEG\b" "$<"
	grep -E "Additional capabilities:.*\bTIFF\b" "$<"
	grep -E "Additional capabilities:.*\bNLS\b" "$<"
	grep -E "Additional capabilities:.*\bcairo\b" "$<"
	grep -E "Options enabled:.*\bshared R library\b" "$<"
	grep -E "Options enabled:.*\bshared BLAS\b" "$<"
	grep -E "Options enabled:.*\bprofiling\b" "$<"
	grep -E "Options enabled:.*\bmemory profiling\b" "$<"


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	make GCC_VERSION=$(GCC_VERSION) assert_gcc_version
	mkdir -p $(BUILD_HOME)/untar
	cd $(BUILD_HOME); \
	curl -O $(DOWNLOAD_URL); \
	tar xvfz $(TARBALL) -C untar; \
	mv untar/* $(BUILD_NAME); \
	rmdir untar

## In R (<= 3.3.0), 'configure' fails to infer zlib version if >= 1.2.10"
## https://github.com/HenrikBengtsson/CBI-software/issues/116
patch_config_zlib: $(BUILD_PATH)/configure
	sed -i '/^#ifdef ZLIB_VERSION/i#ifdef ZLIB_VERNUM\n  if (ZLIB_VERNUM < 0x1250) {\n    exit(1);\n  }\n  exit(0);' "$<"
	sed -i '/^#ifdef ZLIB_VERSION/,/  exit(strncmp(ZLIB_VERSION, "1.2.5", 5) < 0);/d' "$<"

pre_config: assert_gcc_version assert_java_version patch_config_zlib

post_config: assert_config

pre_build: assert_gcc_version assert_java_version

post_build:
	echo "Running 'make check'"
	cd $(BUILD_PATH); \
	R_LIBS_USER=dummy make check &> make-check.log

r_javareconf: assert_java_version
	## Configure R for Java (so that 'rJava' can be installed)
	chmod -R u+w $(PREFIX)/lib*/R/{bin,etc}
	chmod u+w $(PREFIX)/*
	module --force purge; \
	if module load openjdk/$(OPENJDK_VERSION) 2> /dev/null; then \
	    [[ -n $${JAVA_HOME} ]] || { echo >&2 "ERROR: JAVA_HOME not set"; exit 1; } \
	else \
	    >&2 echo "WARNING: Failed to load module 'openjdk/$(OPENJDK_VERSION)'; leaving it to 'R CMD javareconf' to locate a proper Java version (JAVA_HOME)"; \
	fi; \
	JAVA_VERSION=$$(java   -version 2>&1 | head -1 | sed -E 's/.*"(.*)".*/\1/'); \
	JAVAC_VERSION=$$(javac -version 2>&1 | head -1 | sed 's/.* //');             \
	JAVA_VERSION_XY=$$(echo "$${JAVA_VERSION:?}" | sed 's/[.][^.]*$$//');        \
	JAVAC_VERSION_XY=$$(echo "$${JAVAC_VERSION:?}" | sed 's/[.][^.]*$$//');      \
	echo "JAVA_HOME=$${JAVA_HOME}";                                              \
	echo "JAVA_VERSION_XY=$${JAVA_VERSION_XY:?}";                                \
	echo "JAVAC_VERSION_XY=$${JAVAC_VERSION_XY:?}";                              \
	if [[ "$${JAVA_VERSION_XY:?}" != "$${JAVAC_VERSION_XY:?}" ]]; then           \
	    >&2 echo "ERROR: java and javac are of different versions: $${JAVA_VERSION} != $${JAVAC_VERSION}"; \
	    exit 1;                                                                  \
        fi;                                                                          \
	mkdir -p "$(BUILD_PATH)";                                                    \
	if ! $(PREFIX)/bin/R CMD javareconf &> "$(BUILD_PATH)/javareconf.log"; then  \
	    >&2 echo "ERROR: R CMD javareconf failed;";                              \
	    >&2 cat "$(BUILD_PATH)/javareconf.log";                                  \
	    exit 1;                                                                  \
	fi
	cat "$(BUILD_PATH)/javareconf.log"

	## Save log file
	cp "$(BUILD_PATH)/javareconf.log" $(PREFIX)/
	make GCC_VERSION=$(GCC_VERSION) write_protect_install


post_install: r_javareconf
	## Prevent package installations/updates in system library
	chmod -R ugo-w $(PREFIX)/lib*/R/library
	chmod u+w $(PREFIX) $(PREFIX)/*
	cp "$(BUILD_PATH)/config.log" $(PREFIX)/
	cp "$(BUILD_PATH)/make-check.log" $(PREFIX)/
	grep -A 28 -F "R is now configured" "$(BUILD_PATH)/config.log" > "$(PREFIX)/config.log.summary"
	make GCC_VERSION=$(GCC_VERSION) write_protect_install


$(MODULE_TARGET): module.lua.tmpl
	mkdir -p "$(@D)"
	if [[ -f "$@" ]]; then chmod u+w "$@"; fi
	cp "$<" "$@"
	sed -i 's/myModuleVersion[(][)]/"$(MODULE_VERSION)"/' "$@"
	if [[ ! -f "$(MODULE_TARGET_DEFAULT)" ]]; then ln -s "$@" "$(MODULE_TARGET_DEFAULT)"; fi
	make GCC_VERSION=$(GCC_VERSION) write_protect_module
	module --ignore-cache show $(MODULE_NAME_VERSION)
	module load $(MODULE_NAME_VERSION)
	module unload $(MODULE_NAME_VERSION)

available-version:
	@curl --silent https://cran.r-project.org/src/base/R-4/ | grep -E ">R-[[:digit:]]?[.][[:digit:]]?[.][[:digit:]]?[.]tar.gz<" | sed -E 's/.*>R-([[:digit:]]?[.][[:digit:]]?[.][[:digit:]])?[.]tar.gz<.*/\1/' | sort -h | tail -1
