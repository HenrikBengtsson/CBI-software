include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O https://github.com/igorshubovych/markdownlint-cli/archive/refs/tags/$(DOWNLOAD_TARGET_FILE)


$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	module purge; \
	npm install --prefix="$(PREFIX)" "$<"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
