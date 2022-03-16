include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(BUILD_TARGET):
	cd $(BUILD_HOME); \
	virtualenv -p python $(NAME)-$(VERSION)
	command -v python
	cd $(BUILD_PATH); \
	. bin/activate; \
	command -v python; \
	python -m pip install --force --upgrade pip; \
	python -m pip --version; \
	python -m pip install $(NAME)==$(VERSION)

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"


## Keep the following just in case - don't think it's need /HB 2022-02-15
incl/$(VERSION).lua: $(PREFIX)/bin/activate
	mkdir -p "$(@D)"
	module purge; \
	{ \
	    echo "-- Don't edit! Created using: "; \
	    echo "-- $(LMOD_DIR)/sh_to_modulefile $<"; \
	    MANPATH="dummy" $(LMOD_DIR)/sh_to_modulefile "$<"; \
	} > "$@.tmp"
	if grep -q -F "setenv(" "$@.tmp"; then \
	    echo "WARNING: Detected setenv() calls that might have to be edited to become prepend_path():"; \
	    grep -H -n -F "setenv(" "$@.tmp"; \
	fi
	mv "$@.tmp" "$@"

post_install_module: incl/$(VERSION).lua
#	cat $< >> $(MODULE_TARGET)
	make write_protect_module
