#' Example:
#' make VERSION=5.124

include ../utils.mk

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

