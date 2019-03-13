#' Example:
#' make VERSION=5.124

include ../../utils.mk

all: debug build test

$(MODULE_HOME)/$(MODULE_NAME)/$(VERSION).lua: module.lua.tmpl
	mkdir -p "$(@D)"
	cp "$<" "$@"

build: $(MODULE_HOME)/$(MODULE_NAME)/$(VERSION).lua

test: $(MODULE_HOME)/$(MODULE_NAME)/$(VERSION).lua
	module --ignore-cache show $(MODULE_NAME)/$(VERSION)
	module load $(MODULE_NAME)/$(VERSION)
	module unload $(MODULE_NAME)/$(VERSION)

