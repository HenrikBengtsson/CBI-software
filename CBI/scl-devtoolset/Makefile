include config.mk
include ../utils.mk

all: debug install_module

.incl: .incl/4.lua .incl/6.lua .incl/7.lua .incl/8.lua .incl/9.lua

.incl/%.lua: /opt/rh/devtoolset-%/enable
	mkdir -p .incl/
	echo "-- Don't edit! Created using: " > $@
	echo "-- $(LMOD_DIR)/sh_to_modulefile $<" >> $@
	$(LMOD_DIR)/sh_to_modulefile $< >> $@

clean:
	rm -f s.log
	rm -rf .incl/

$(MODULE_TARGET): $(VERSION).lua
	mkdir -p "$(@D)"
	cp "$<" "$@"

