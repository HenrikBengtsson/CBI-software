include config.mk
include ../utils.mk

## Make sure there is a default, so we can load the hidden module
## without having to specify the version, which is irrelevant
post_install_module:
	cd "$$(dirname "$(MODULE_TARGET)")"; \
	ln -fs "$(MODULE_TARGET)" default
