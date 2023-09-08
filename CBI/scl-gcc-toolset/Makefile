include config.mk
include ../utils.mk

incl: incl/9.lua incl/10.lua incl/11.lua incl/12.lua

incl/%.lua: /opt/rh/gcc-toolset-%/enable
	@[[ -f "$<" ]] || { >&2 echo "ERROR: SCL gcc-toolset-$(VERSION) does not exist on $$HOSTNAME"; exit 1; }
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
	@[[ -d /opt/rh/gcc-toolset-$(VERSION) ]] || { 2>&1 echo "ERROR: SCL gcc-toolset-$(VERSION) does not exist on $$HOSTNAME"; exit 1; }
	mkdir -p "$(@D)"
	cp "$<" "$@"

test: tests/all.sh tests/*.bats
	echo "SHELL=$$SHELL"
	tests/all.sh
