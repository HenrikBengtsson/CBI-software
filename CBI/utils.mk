SHELL=bash

include $(dir $(lastword $(MAKEFILE_LIST)))version.mk
include $(dir $(lastword $(MAKEFILE_LIST)))sysinfo.mk

ifndef NAME
  $(error ERROR: Environment variable 'NAME' is not set)
endif

ifndef LINUX_DISTRO_SPECIFIC
  LINUX_DISTRO_SPECIFIC=false
else ifeq ($(LINUX_DISTRO_SPECIFIC),true)
  ifndef _LINUX_DISTRO_
    ifdef CBI_LINUX
      _LINUX_DISTRO_=$(CBI_LINUX)
    endif
  endif
  ifndef _LINUX_DISTRO_
    $(error ERROR: Environment variable '_LINUX_DISTRO_' is not set)
  endif
endif


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## CORE
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ifndef BUILD_HOME
  ifndef TMPDIR
    TMPDIR=/tmp
  endif
  BUILD_HOME=$(TMPDIR)/$(shell date +%Y%m%d)
endif

ifndef BUILD_NAME
  BUILD_NAME=$(NAME)-$(VERSION)$(BUILD_SUFFIX)
endif

ifndef BUILD_PATH
  ifdef DOWNLOAD_PATH
    BUILD_PATH=$(DOWNLOAD_PATH)
  else
    BUILD_PATH=$(BUILD_HOME)/$(BUILD_NAME)
  endif
endif


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## DOWNLOADING
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ifndef DOWNLOAD
  DOWNLOAD=true
endif

ifeq ($(DOWNLOAD),true)
  ifndef DOWNLOAD_PATH
    DOWNLOAD_PATH=$(BUILD_HOME)/$(BUILD_NAME)
  endif
  ifndef DOWNLOAD_TARGET
    ifndef DOWNLOAD_TARGET_FILE
      DOWNLOAD_TARGET_FILE=configure
    endif
    DOWNLOAD_TARGET=$(DOWNLOAD_PATH)/$(DOWNLOAD_TARGET_FILE)
  endif
  ifndef TARBALL
    TARBALL=$(NAME)-$(VERSION)$(BUILD_SUFFIX).tar.gz
  endif
else
  DOWNLOAD_PATH=
  DOWNLOAD_TARGET_FILE=
  DOWNLOAD_TARGET=
  TARBALL=
endif



## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## CONFIGURE
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ifndef CONFIG
  CONFIG=true
endif

ifeq ($(CONFIG),true)
  ifndef CONFIG_TARGET_FILE
    CONFIG_TARGET_FILE=config.log
  endif
  ifndef CONFIG_TARGET
    CONFIG_TARGET=$(BUILD_PATH)/$(CONFIG_TARGET_FILE)
  endif
else
  CONFIG_TARGET_FILE=
  CONFIG_TARGET=
endif

ifndef CONFIG_MODULES
  CONFIG_MODULES=
endif

## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## BUILDING
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ifndef BUILD
  BUILD=true
endif

ifeq ($(BUILD),true)
  ifndef BUILD_TARGET
    ifndef BUILD_TARGET_FILE
      $(error ERROR: Environment variable 'BUILD_TARGET_FILE' is not set)
    endif
    BUILD_TARGET=$(BUILD_PATH)/$(BUILD_TARGET_FILE)
  endif
else
  BUILD_TARGET=
  INSTALL_TARGET=
endif

ifndef BUILD_MODULES
  BUILD_MODULES=$(CONFIG_MODULES)
endif


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## INSTALLATION
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ifndef INSTALL
  INSTALL=true
endif

ifeq ($(INSTALL),true)
  ifndef SOFTWARE_HOME
    ifdef SOFTWARE_ROOT_CBI
      SOFTWARE_HOME=$(SOFTWARE_ROOT_CBI)
    else
      $(error ERROR: Environment variable 'SOFTWARE_HOME' is not set)
    endif
  endif

  ifeq ($(LINUX_DISTRO_SPECIFIC),true)
    ifneq ($(patsubst %$(_LINUX_DISTRO_),,$(lastword $(SOFTWARE_HOME))),)
      SOFTWARE_HOME:=$(SOFTWARE_HOME)/_$(_LINUX_DISTRO_)
    endif
  endif

  ifndef INSTALL_TARGET
    ifndef INSTALL_TARGET_FILE
      $(error ERROR: Environment variable 'INSTALL_TARGET_FILE' is not set)
    endif
    INSTALL_TARGET=$(PREFIX)/$(INSTALL_TARGET_FILE)
  endif

  ifndef PREFIX
    PREFIX=$(SOFTWARE_HOME)/$(NAME)-$(VERSION)
  endif
else
  INSTALL_TARGET=
  PREFIX=
endif



## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## MAKE RULES
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
all: debug install install_module modulerc check

modulerc:
	cd ..; make MODULE_HOME=$(MODULE_HOME_ORG) '$@'

remove: uninstall uninstall_module

download: $(DOWNLOAD_TARGET)

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	make --quiet pre_config
	module --force purge; \
	module load $(CONFIG_MODULES); \
	module list; \
	echo "LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}"; \
	cd $(BUILD_PATH); \
	./configure $(CONFIG_OPTS) --prefix=$(PREFIX)
	make --quiet post_config

ifeq ($(CONFIG),false)
$(CONFIG_TARGET):
endif

config: $(CONFIG_TARGET)

pre_config:

post_config:


$(BUILD_TARGET): $(CONFIG_TARGET)
	make --quiet pre_build
	module --force purge; \
	module load $(BUILD_MODULES); \
	module list; \
	cd $(BUILD_PATH); \
	make $(BUILD_OPTS)
	make --quiet post_build

ifeq ($(BUILD),false)
$(BUILD_TARGET):
endif

build: $(BUILD_TARGET)

pre_build:

post_build:

$(INSTALL_TARGET): $(BUILD_TARGET)
	make --quiet pre_install
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH); \
	make --quiet install
	make --quiet post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

ifeq ($(INSTALL),false)
$(INSTALL_TARGET):
endif

pre_install:

post_install:
	make --quiet write_protect_install

install: $(INSTALL_TARGET)

uninstall:
	if [[ -d "$(PREFIX)" ]]; then \
	    chmod -R u+w "$(PREFIX)"; \
	    rm -rf "$(PREFIX)"; \
	fi


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## MODULE
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ifndef INSTALL_MODULE
  INSTALL_MODULE=true
endif

ifdef MODULE_HOME
  MODULE_HOME_ORG:=$(MODULE_HOME)
endif

ifeq ($(INSTALL_MODULE),true)
  ifndef MODULE_HOME
    $(error ERROR: Environment variable 'MODULE_HOME' is not set)
  endif

  ifeq ($(LINUX_DISTRO_SPECIFIC),true)
    ifneq ($(patsubst %$(_LINUX_DISTRO_),,$(lastword $(MODULE_HOME))),)
      MODULE_HOME:=$(MODULE_HOME)/_$(_LINUX_DISTRO_)
    endif
  endif

  ifndef FULLNAME
    FULLNAME=$(shell basename "$(PREFIX)")
  endif
  
  ifndef MODULE_NAME
    MODULE_NAME=$(shell echo "$(NAME)" | tr A-Z a-z)
  endif
  
  ifndef MODULE_VERSION
    MODULE_VERSION=$(VERSION)
  endif
  
  ifndef MODULE_HIDDEN
    MODULE_HIDDEN=false
  endif
  
  ## An Lmod module is hidden from 'module avail' and 'module spider'
  ## if it's version is prefixed with a period, e.g. java-tweaks/.0.1
  ifeq ($(MODULE_HIDDEN),true)
    MODULE_VERSION:=.$(MODULE_VERSION)
  endif
  
  MODULE_NAME_VERSION=$(MODULE_NAME)/$(MODULE_VERSION)
  
  
  ifndef MODULE_TARGET
    MODULE_TARGET=$(MODULE_HOME)/$(MODULE_NAME_VERSION).lua
  endif
endif

$(MODULE_TARGET): module.lua.tmpl
	make --quiet pre_install_module
	mkdir -p "$(@D)"
	chmod u+w "$@" 2> /dev/null || true
	cp "$<" "$@"
	make --quiet post_install_module
	module --ignore-cache show $(MODULE_NAME_VERSION)
	module load CBI
	module load $(MODULE_NAME_VERSION)
	module unload $(MODULE_NAME_VERSION)

ifeq ($(INSTALL_MODULE),false)
$(MODULE_TARGET):
endif

pre_install_module:

post_install_module:
	make --quiet write_protect_module

module: $(MODULE_TARGET)

## BACKWARD COMPATIBILTY
install_module: module

uninstall_module:
	if [[ -f "$(MODULE_TARGET)" ]]; then \
	    chmod u+w "$(MODULE_TARGET)"; \
	    rm -rf "$(MODULE_TARGET)"; \
	fi

test_module: $(MODULE_TARGET)
	module --ignore-cache show $(MODULE_NAME_VERSION)
	module load $(MODULE_NAME_VERSION)
	module unload $(MODULE_NAME_VERSION)


write_protect_install:
	chmod -R ugo-w "$(PREFIX)"

write_protect_module:
	chmod ugo-w "$(MODULE_TARGET)"

write_protect: write_protect_module write_protect_install

write_unprotect_install: $(PREFIX)
	chmod -R u+w "$(PREFIX)"

.LOW_RESOLUTION_TIME: $(INSTALL_TARGET) $(MODULE_TARGET)

## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## checks
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
check-export:
	@echo "export MODULE_REPO=CBI"
	@echo "export MODULE_NAME=$(MODULE_NAME)"
	@if $(MODULE_HIDDEN); then \
	    echo "export MODULE_VERSION=.$(VERSION)"; \
	else \
	    echo "export MODULE_VERSION=$(VERSION)"; \
	fi
	@echo "export INSTALL_TARGET=$(INSTALL_TARGET)"
	@echo "export INSTALL_TARGET_NAME=$$(basename "$(INSTALL_TARGET)")"
	@echo "export VERSION=$(VERSION)"
	@echo "export MODULE_HIDDEN=$(MODULE_HIDDEN)"
	@echo "export PREFIX=$(PREFIX)"

check:
	@if module load CBI bats-core bats-assert bats-file &> /dev/null; then \
	    eval "$$(make --quiet check-export 2> /dev/null)"; \
	    echo "*** Generic checks ..."; \
	    bats ../.incl/tests/*.bats; \
	    if [[ -d tests ]]; then \
	        echo "*** Software-specific checks ..."; \
	        (cd tests; bats *.bats); \
	    else \
	        echo "*** Software-specific checks ... none (missing tests/ folder)"; \
	    fi; \
	fi

check-libs:
	@if module load CBI bats-core bats-assert bats-file &> /dev/null; then \
	    eval "$$(make --quiet check-export 2> /dev/null)"; \
	    echo "*** Missing library checks ..."; \
	    bats ../.incl/tests/*.libs.bats; \
	fi

check-rpath:
	@if module load CBI bats-core bats-assert bats-file &> /dev/null; then \
	    eval "$$(make --quiet check-export 2> /dev/null)"; \
	    echo "*** RUNPATH checks ..."; \
	    bats ../.incl/tests/*.rpath.bats; \
	fi

check-absolute-paths:
	@if module load CBI bats-core bats-assert bats-file &> /dev/null; then \
	    eval "$$(make --quiet check-export 2> /dev/null)"; \
	    echo "*** Absolute paths checks ..."; \
	    bats ../.incl/tests/*.absolute-paths.bats; \
	fi


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## HELP
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
help:
	@echo "Known 'make' targets:"
	@make -qp | awk -F ':' '/^(|\/)[a-zA-Z0-9][^$$#\t=]*:([^=]|$$)/ { split($$1,A,/ /); for(i in A) print A[i] }' | sort -u


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## DEBUG
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
debug:
	@echo "NAME: $(NAME)"
	@echo "VERSION: $(VERSION)"
	@echo "VERSION_X_Y_Z: $(VERSION_X_Y_Z)"
	@echo "VERSION_X_Y: $(VERSION_X_Y)"
	@echo "VERSION_X: $(VERSION_X)"
	@echo "VERSION_Y: $(VERSION_Y)"
	@echo "URL: $(URL)"
	@echo "LINUX_DISTRO_SPECIFIC: $(LINUX_DISTRO_SPECIFIC)"
	@echo "_LINUX_DISTRO_: $(_LINUX_DISTRO_)"
	@echo
	@echo "CORE:"
	@echo "TMPDIR*: $(TMPDIR)"
	@echo "BUILD_HOME: $(BUILD_HOME)"
	@echo "BUILD_NAME: $(BUILD_NAME)"
	@echo "BUILD_PATH: $(BUILD_PATH)"
	@echo
	@echo "DOWNLOADING:"
	@echo "DOWNLOAD: $(DOWNLOAD)"
	@echo "TARBALL*: $(TARBALL)"
	@echo "DOWNLOAD_PATH: $(DOWNLOAD_PATH)"
	@echo "DOWNLOAD_TARGET_FILE: $(DOWNLOAD_TARGET_FILE)"
	@echo "DOWNLOAD_TARGET: $(DOWNLOAD_TARGET)"
	@echo
	@echo "CONFIGURE:"
	@echo "CONFIG: $(CONFIG)"
	@echo "CONFIG_OPTS*: $(CONFIG_OPTS)"
	@echo "CONFIG_TARGET_FILE: $(CONFIG_TARGET_FILE)"
	@echo "CONFIG_TARGET: $(CONFIG_TARGET)"
	@echo "CONFIG_MODULES: $(CONFIG_MODULES)"
	@echo
	@echo "BUILDING:"
	@echo "BUILD: $(BUILD)"
	@echo "BUILD_OPTS*: $(BUILD_OPTS)"
	@echo "BUILD_SUFFIX*: $(BUILD_SUFFIX)"
	@echo "BUILD_TARGET_FILE: $(BUILD_TARGET)"
	@echo "BUILD_TARGET: $(BUILD_TARGET)"
	@echo "BUILD_MODULES: $(BUILD_MODULES)"
	@echo
	@echo "INSTALLATION:"
	@echo "INSTALL: $(INSTALL)"
	@echo "INSTALL_TARGET: $(INSTALL_TARGET)"
	@echo "SOFTWARE_HOME: $(SOFTWARE_HOME)"
	@echo "PREFIX: $(PREFIX)"
	@echo
	@echo "MODULES:"
	@echo "INSTALL_MODULE: $(INSTALL_MODULE)"
	@echo "MODULE_HOME: $(MODULE_HOME)"
	@echo "MODULE_NAME: $(MODULE_NAME)"
	@echo "MODULE_VERSION: $(MODULE_VERSION)"
	@echo "MODULE_HIDDEN: $(MODULE_HIDDEN)"
	@echo "MODULE_NAME_VERSION: $(MODULE_NAME_VERSION)"
	@echo "FULLNAME: $(FULLNAME)"
	@echo "MODULE_TARGET: $(MODULE_TARGET)"
	@echo
	@echo "ARCHITECTURE:"
	@echo "LINUX_NAME: $(LINUX_NAME)"
	@echo "LINUX_VERSION: $(LINUX_VERSION)"


version:
	@echo "$(VERSION)"
