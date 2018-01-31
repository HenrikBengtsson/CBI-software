#' Example:
#' make VERSION=5.124

SHELL=bash

NAME=byobu

ifndef MODULE_HOME
  $(error ERROR: Environment variable 'MODULE_HOME' is not set)
endif

ifndef PREFIX
  ifndef VERSION
    $(error ERROR: Environment variable 'VERSION' is not set)
  endif
  ifndef SOFTWARE_HOME
    $(error ERROR: Environment variable 'SOFTWARE_HOME' is not set)
  endif
  PREFIX=$(SOFTWARE_HOME)/$(NAME)-$(VERSION)
else
  FULLNAME=$(basename $(PREFIX))
endif

MODULE_NAME=$(NAME)
MODULE_NAME_VERSION=$(MODULE_NAME)/$(VERSION)

all: debug build test

debug:
	@echo "PREFIX: $(PREFIX)"
	@echo "NAME: $(NAME)"
	@echo "VERSION: $(VERSION)"
	@echo "MODULE_HOME: $(MODULE_HOME)"
	@echo "MODULE_NAME: $(MODULE_NAME)"

$(MODULE_HOME)/$(MODULE_NAME)/$(VERSION).lua: module.lua.tmpl
	mkdir -p "$(@D)"
	cp "$<" "$@"

build: $(MODULE_HOME)/$(MODULE_NAME)/$(VERSION).lua

test: $(MODULE_HOME)/$(MODULE_NAME)/$(VERSION).lua
	module --ignore-cache show $(MODULE_NAME)/$(VERSION)
	module load $(MODULE_NAME)/$(VERSION)
	module unload $(MODULE_NAME)/$(VERSION)

