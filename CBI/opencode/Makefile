include config.mk
include ../utils.mk

NAME2=opencode-ai

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

$(INSTALL_TARGET):
	mkdir -p $(BUILD_PATH)
	cd $(BUILD_PATH); \
	module purge; \
	npm_config_cache="$$(mktemp -d)" npm install "$(NAME2)@$(VERSION)" --prefix "$(PREFIX)"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@npm_config_cache="$$(mktemp -d)" npm view "$(NAME2)" version 2> /dev/null

