include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

incl/conda.sh.lua: $(PREFIX)/etc/profile.d/conda.sh
	mkdir -p "$(@D)"
	module purge; \
	{ \
	    echo "-- Don't edit! Created using: "; \
	    echo "-- $(LMOD_DIR)/sh_to_modulefile $<"; \
	    $(LMOD_DIR)/sh_to_modulefile "$<"; \
	} > "$@.tmp"
	mv "$@.tmp" "$@"

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O https://repo.anaconda.com/miniconda/$(DOWNLOAD_TARGET_FILE)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	module purge; \
	bash "$<" -b -p "$(PREFIX)"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

$(MODULE_TARGET): module.lua.tmpl incl/conda.sh.lua
	mkdir -p "$(@D)"
	cat $^ > "$@"
	make post_install_module


