include config.mk
include ../utils.mk

all: debug install_module

.incl: .incl/30.lua .incl/27.lua .incl/26.lua .incl/25.lua

.incl/%.lua: /opt/rh/rh-ruby%/enable
	mkdir -p .incl/
	echo "-- Don't edit! Created using: " > $@
	echo "-- $(LMOD_DIR)/sh_to_modulefile $<" >> $@
	LD_LIBRARY_PATH= $(LMOD_DIR)/sh_to_modulefile $< >> $@

clean:
	rm -f s.log
	rm -rf .incl/

$(MODULE_TARGET): $(VERSION).lua
	mkdir -p "$(@D)"
	cat module.lua.tmpl > "$@".tmp
	cat "$<" >> "$@".tmp
	mv "$@".tmp "$@"


