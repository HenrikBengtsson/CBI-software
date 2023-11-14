include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

## See https://docs.conda.io/en/latest/miniconda.html
$(DOWNLOAD_TARGET):
	>&2 echo "ERROR: This is a defunction CBI software tool - don't install it. Instead, install the 'miniconda3' tool"
	exit 1

$(INSTALL_TARGET):
	>&2 echo "ERROR: This is a defunction CBI software tool - don't install it. Instead, install the 'miniconda3' tool"
	exit 1


$(MODULE_TARGET): module.lua.tmpl
	mkdir -p "$(@D)"
	[[ ! -f "$@" ]] || chmod u+w "$@"
	cat $^ > "$@.tmp"
	luac -p "$@.tmp"
	mv "$@.tmp" "$@"
	make post_install_module
