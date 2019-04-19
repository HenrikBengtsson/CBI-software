SHELL=bash

ifndef NAME
  $(error ERROR: Environment variable 'NAME' is not set)
endif

ifndef VERSION
  $(error ERROR: Environment variable 'VERSION' is not set)
endif


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## CORE
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ifndef BUILD_HOME
  ifndef TMPDIR
    $(error ERROR: Environment variable 'TMPDIR' is not set)
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


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## INSTALLATION
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ifndef SOFTWARE_HOME
  ifdef SOFTWARE_ROOT_CBI
    SOFTWARE_HOME=$(SOFTWARE_ROOT_CBI)
  else
    $(error ERROR: Environment variable 'SOFTWARE_HOME' is not set)
  endif
endif

ifndef PREFIX
  PREFIX=$(SOFTWARE_HOME)/$(NAME)-$(VERSION)
endif

ifndef INSTALL_TARGET
  ifndef INSTALL_TARGET_FILE
    $(error ERROR: Environment variable 'INSTALL_TARGET_FILE' is not set)
  endif
  INSTALL_TARGET=$(PREFIX)/$(INSTALL_TARGET_FILE)
endif



## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## MAKE RULES
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
download: $(DOWNLOAD_TARGET)

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	module purge; \
	cd $(BUILD_PATH); \
	./configure $(CONFIG_OPTS) --prefix=$(PREFIX)

ifeq ($(CONFIG),false)
$(CONFIG_TARGET):
endif

config: $(CONFIG_TARGET)


$(BUILD_TARGET): $(CONFIG_TARGET)
	module purge; \
	cd $(BUILD_PATH); \
	make $(BUILD_OPTS)
	make post_build

ifeq ($(BUILD),false)
$(BUILD_TARGET):
endif

build: $(BUILD_TARGET)

post_build:

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH); \
	make install
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

post_install:

install: $(INSTALL_TARGET)


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## MODULE
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ifndef MODULE_HOME
  $(error ERROR: Environment variable 'MODULE_HOME' is not set)
endif

ifndef FULLNAME
  FULLNAME=$(shell basename "$(PREFIX)")
endif

ifndef MODULE_NAME
  MODULE_NAME=$(NAME)
endif

MODULE_NAME_VERSION=$(MODULE_NAME)/$(VERSION)


ifndef MODULE_TARGET
  MODULE_TARGET=$(MODULE_HOME)/$(MODULE_NAME)/$(VERSION).lua
endif

$(MODULE_TARGET): module.lua.tmpl
	mkdir -p "$(@D)"
	cp "$<" "$@"
	module --ignore-cache show $(MODULE_NAME)/$(VERSION)
	module load $(MODULE_NAME)/$(VERSION)
	module unload $(MODULE_NAME)/$(VERSION)

install_module: $(MODULE_TARGET)

test_module: $(MODULE_TARGET)
	module --ignore-cache show $(MODULE_NAME)/$(VERSION)
	module load $(MODULE_NAME)/$(VERSION)
	module unload $(MODULE_NAME)/$(VERSION)


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## DEBUG
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
debug:
	@echo "NAME: $(NAME)"
	@echo "VERSION: $(VERSION)"
	@echo "URL: $(URL)"
	@echo
	@echo "CORE:"
	@echo "TMPDIR*: $(TMPDIR)"
	@echo "BUILD_HOME: $(BUILD_HOME)"
	@echo "BUILD_NAME: $(BUILD_NAME)"
	@echo "BUILD_PATH: $(BUILD_PATH)"
	@echo
	@echo "DOWNLOADING:"
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
	@echo
	@echo "BUILDING:"
	@echo "BUILD: $(BUILD)"
	@echo "BUILD_SUFFIX*: $(BUILD_SUFFIX)"
	@echo "BUILD_TARGET_FILE: $(BUILD_TARGET)"
	@echo "BUILD_TARGET: $(BUILD_TARGET)"
	@echo
	@echo "MODULES:"
	@echo "MODULE_HOME: $(MODULE_HOME)"
	@echo "MODULE_NAME: $(MODULE_NAME)"
	@echo "MODULE_NAME_VERSION: $(MODULE_NAME_VERSION)"
	@echo "FULLNAME: $(FULLNAME)"
	@echo "MODULE_TARGET: $(MODULE_TARGET)"
	@echo
	@echo "INSTALLATION:"
	@echo "SOFTWARE_HOME: $(SOFTWARE_HOME)"
	@echo "PREFIX: $(PREFIX)"
	@echo "INSTALL_TARGET: $(INSTALL_TARGET)"



## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## EVERYTHING
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
all: debug install install_module
