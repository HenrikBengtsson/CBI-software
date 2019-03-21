SHELL=bash

ifndef NAME
  $(error ERROR: Environment variable 'NAME' is not set)
endif

ifndef VERSION
  $(error ERROR: Environment variable 'VERSION' is not set)
endif


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## DOWNLOADING
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ifndef DOWNLOAD_TARGET
  ifndef DOWNLOAD_TARGET_FILE
    DOWNLOAD_TARGET_FILE=configure
  endif
  DOWNLOAD_TARGET=$(BUILD_PATH)/$(DOWNLOAD_TARGET_FILE)
endif

ifndef TARBALL
  TARBALL=$(NAME)-$(VERSION)$(BUILD_SUFFIX).tar.gz
endif


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## BUILDING
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ifndef BUILD_HOME
  ifndef TMPDIR
    $(error ERROR: Environment variable 'TMPDIR' is not set)
  endif
  BUILD_HOME=$(TMPDIR)
endif

ifndef BUILD_NAME
  BUILD_NAME=$(NAME)-$(VERSION)$(BUILD_SUFFIX)
endif

ifndef BUILD_PATH
  BUILD_PATH=$(BUILD_HOME)/$(BUILD_NAME)
endif

ifndef CONFIG_TARGET_FILE
  CONFIG_TARGET_FILE=config.log
endif

ifndef CONFIG_TARGET
  CONFIG_TARGET=$(BUILD_PATH)/$(CONFIG_TARGET_FILE)
endif

ifndef BUILD_TARGET
  ifndef BUILD_TARGET_FILE
    $(error ERROR: Environment variable 'BUILD_TARGET_FILE' is not set)
  endif
  BUILD_TARGET=$(BUILD_PATH)/$(BUILD_TARGET_FILE)
endif

ifndef INSTALL_TARGET
  ifndef INSTALL_TARGET_FILE
    $(error ERROR: Environment variable 'INSTALL_TARGET_FILE' is not set)
  endif
  INSTALL_TARGET=$(PREFIX)/$(INSTALL_TARGET_FILE)
endif


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## SOFTWARE
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

download_software: $(DOWNLOAD_TARGET)

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	module purge
	cd $(BUILD_PATH); \
	./configure $(CONFIG_OPTS) --prefix=$(PREFIX)

config_software: $(CONFIG_TARGET)

$(BUILD_TARGET): $(CONFIG_TARGET)
	module purge;
	cd $(BUILD_PATH); \
	make $(BUILD_OPTS)
	make post_build_software

build_software: $(BUILD_TARGET)

post_build_software:

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(SOFTWARE_HOME)
	cd $(BUILD_PATH); \
	make install
	make post_install_software
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

post_install_software:

install_software: $(INSTALL_TARGET)


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
	@echo "DOWNLOADING:"
	@echo "TARBALL*: $(TARBALL)"
	@echo "DOWNLOAD_TARGET: $(DOWNLOAD_TARGET)"
	@echo
	@echo "BUILDING:"
	@echo "TMPDIR*: $(TMPDIR)"
	@echo "BUILD_HOME: $(BUILD_HOME)"
	@echo "BUILD_NAME: $(BUILD_NAME)"
	@echo "BUILD_SUFFIX*: $(BUILD_SUFFIX)"
	@echo "BUILD_PATH: $(BUILD_PATH)"
	@echo "CONFIG_OPTS*: $(CONFIG_OPTS)"
	@echo "CONFIG_TARGET: $(CONFIG_TARGET)"
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
install: install_software install_module

all: debug install
