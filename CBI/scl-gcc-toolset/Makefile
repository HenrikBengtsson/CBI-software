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
	if ! $${SETENV_FIXED:-false} && grep -q -F "setenv(" "$@.tmp"; then \
	    { \
	       echo "ERROR: Detected setenv() calls that might have to be edited to become prepend_path():"; \
	       grep -H -n -F "setenv(" "$@.tmp"; \
	       echo "Please edit '$@.tmp' as needed and rename to '$@' when done"; \
	    } >&2; \
	    exit 1; \
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

available-version:
	@scl list-collections | grep gcc-toolset | sed 's/gcc-toolset-//' | sort -r -h | head -1
