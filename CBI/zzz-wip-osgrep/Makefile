include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

post_install:
	npx run --prefix="$(PREFIX)" osgrep setup

$(INSTALL_TARGET):
	mkdir -p $(BUILD_PATH)
	cd $(BUILD_PATH); \
	module purge; \
	npm_config_cache="$$(mktemp -d)" npm install --prefix="$(PREFIX)" osgrep@$(VERSION)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	npm_config_cache="$$(mktemp -d)" npm view osgrep version 2> /dev/null

