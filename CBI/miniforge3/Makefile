include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

GITHUB_REPO=https://github.com/conda-forge/miniforge

## See https://conda-forge.org/miniforge/
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/$(CONDA_VERSION)/$(DOWNLOAD_TARGET_FILE)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	module purge; \
	bash "$<" -b -p "$(PREFIX)"
	"$(PREFIX)"/bin/conda config --system --set notify_outdated_conda false
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

## -- IMPORTANT:
## conda.sh.lua becomes incomplete when using Lmod 8.2.7
## (2019-11-30), which is what's available on CentOS 7. It
## works as wanted with Lmod 8.6 (2021-12-06). Because of
## this, we source conda.sh in the module instead.
incl/conda-$(VERSION).sh.lua: $(PREFIX)/etc/profile.d/conda.sh
	mkdir -p "$(@D)"
	module purge; \
	{ \
	    echo "-- Don't edit! Created using: "; \
	    echo "-- $(LMOD_DIR)/sh_to_modulefile $<"; \
	    $(LMOD_DIR)/sh_to_modulefile "$<"; \
	} > "$@.tmp"
	luac -p "$@.tmp"
	sed -i -E 's/setenv[(]"(CONDA_|_CE_)/pushenv("\1/g' "$@.tmp"
	luac -p "$@.tmp"
	mv "$@.tmp" "$@"

$(MODULE_TARGET): module.lua.tmpl incl/conda-$(VERSION).sh.lua
	mkdir -p "$(@D)"
	[[ ! -f "$@" ]] || chmod u+w "$@"
	cat $^ > "$@.tmp"
	luac -p "$@.tmp"
	mv "$@.tmp" "$@"
	make post_install_module
