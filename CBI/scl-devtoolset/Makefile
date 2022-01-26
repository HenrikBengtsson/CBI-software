include config.mk
include ../utils.mk

all: debug install_module

incl: incl/4.lua incl/6.lua incl/7.lua incl/8.lua incl/9.lua incl/10.lua incl/11.lua

incl/%.lua: /opt/rh/devtoolset-%/enable
	mkdir -p "$(@D)"
	module purge; \
	{ \
	    echo "-- Don't edit! Created using: "; \
	    echo "-- $(LMOD_DIR)/sh_to_modulefile $<"; \
	    LD_LIBRARY_PATH= $(LMOD_DIR)/sh_to_modulefile "$<"; \
	} > "$@.tmp"
	if grep -q -F "setenv(" "$@.tmp"; then \
	    echo "WARNING: Detected setenv() calls that might have to be edited to become prepend_path():"; \
	    grep -H -n -F "setenv(" "$@.tmp"; \
	fi
	mv "$@.tmp" "$@"

clean:
	rm -f s.log
	rm -rf incl/

%.lua: module.lua.tmpl incl/%.lua
	cat $^ > "$@"

$(MODULE_TARGET): $(VERSION).lua
	mkdir -p "$(@D)"
	cp "$<" "$@"

