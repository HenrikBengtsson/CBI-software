SHELL=bash

ifndef NAME
  $(error ERROR: Environment variable 'NAME' is not set)
endif

ifndef VERSION
  $(error ERROR: Environment variable 'VERSION' is not set)
endif

TARBALL=$(NAME)-$(VERSION)$(BUILD_SUFFIX).tar.gz

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

ifndef SOFTWARE_HOME
  $(error ERROR: Environment variable 'SOFTWARE_HOME' is not set)
endif

ifndef PREFIX
  PREFIX=$(SOFTWARE_HOME)/$(NAME)-$(VERSION)
endif



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


debug:
	@echo "NAME: $(NAME)"
	@echo "VERSION: $(VERSION)"
	@echo "TMPDIR*: $(TMPDIR)"
	@echo "TARBALL*: $(TARBALL)"
	@echo "SOFTWARE_HOME: $(SOFTWARE_HOME)"
	@echo "PREFIX: $(PREFIX)"
	@echo "BUILD_HOME: $(BUILD_HOME)"
	@echo "BUILD_PATH: $(BUILD_PATH)"
	@echo "BUILD_SUFFIX*: $(BUILD_SUFFIX)"
	@echo "BUILD_NAME: $(BUILD_NAME)"
	@echo "MODULE_HOME: $(MODULE_HOME)"
	@echo "MODULE_NAME: $(MODULE_NAME)"
	@echo "MODULE_NAME_VERSION: $(MODULE_NAME_VERSION)"
	@echo "FULLNAME: $(FULLNAME)"
	@echo "URL: $(URL)"

all: debug install

install: install_software install_module

install_software:
	cd install; \
	make NAME=$(NAME)

install_module: build_module test_module

$(MODULE_HOME)/$(MODULE_NAME)/$(VERSION).lua: module/module.lua.tmpl
	mkdir -p "$(@D)"
	cp "$<" "$@"

build_module: $(MODULE_HOME)/$(MODULE_NAME)/$(VERSION).lua

test_module: $(MODULE_HOME)/$(MODULE_NAME)/$(VERSION).lua
	module --ignore-cache show $(MODULE_NAME)/$(VERSION)
	module load $(MODULE_NAME)/$(VERSION)
	module unload $(MODULE_NAME)/$(VERSION)
