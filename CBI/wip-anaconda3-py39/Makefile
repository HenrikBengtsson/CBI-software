include config.mk
include ../utils.mk

ifeq ($(VERSION),22.9.0)
  DOWNLOAD_VERSION=2022.10
endif

DOWNLOAD_TARGET_FILE=$(NAME2)-$(DOWNLOAD_VERSION)-Linux-x86_64.sh

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

## See https://www.anaconda.com/products/distribution
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -O https://repo.anaconda.com/archive/$(DOWNLOAD_TARGET_FILE)

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
incl/conda.sh.lua: $(PREFIX)/etc/profile.d/conda.sh
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

$(MODULE_TARGET): module.lua.tmpl incl/conda.sh.lua
	mkdir -p "$(@D)"
	[[ ! -f "$@" ]] || chmod u+w "$@"
	cat $^ > "$@.tmp"
	luac -p "$@.tmp"
	mv "$@.tmp" "$@"
	make post_install_module
