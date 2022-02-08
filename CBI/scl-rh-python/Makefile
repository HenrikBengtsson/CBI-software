include config.mk
include ../utils.mk

incl: incl/36.lua incl/38.lua

incl/%.lua: /opt/rh/rh-python%/enable
	[[ -f "$<" ]] || { >&2 echo "ERROR: SCL rh-python$(VERSION) does not exist on $$HOSTNAME"; exit 1; }
	mkdir -p "$(@D)"
	module purge; \
	{ \
	    echo "-- Don't edit! Created using: "; \
	    echo "-- $(LMOD_DIR)/sh_to_modulefile $<"; \
	    LD_LIBRARY_PATH="dummy" PKG_CONFIG_PATH="dummy" XDG_DATA_DIRS="dummy" $(LMOD_DIR)/sh_to_modulefile "$<"; \
	} > "$@.tmp"
	if grep -q -F "setenv(" "$@.tmp"; then \
	    echo "WARNING: Detected setenv() calls that might have to be edited to become prepend_path():"; \
	    grep -H -n -F "setenv(" "$@.tmp"; \
	fi
	mv "$@.tmp" "$@"

clean:
	rm -f s.log
	rm -rf .incl/

%.lua: module.lua.tmpl incl/%.lua
	cat $^ > "$@"

$(MODULE_TARGET): $(VERSION).lua
	@[[ -d /opt/rh/rh-python$(VERSION) ]] || { 2>&1 echo "ERROR: SCL rh-python$(VERSION) does not exist on $$HOSTNAME"; exit 1; }
	mkdir -p "$(@D)"
	cp "$<" "$@"
