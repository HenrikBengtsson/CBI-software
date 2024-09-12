include config.mk
include ../utils.mk

VERSION_NO_DOTS=$(subst .,,$(VERSION))
ZIPBALL=$(NAME)-$(VERSION_NO_DOTS)-Linux_x86_64.zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -o $(ZIPBALL) -L -O https://cloud.biohpc.swmed.edu/index.php/s/hisat2-$(VERSION_NO_DOTS)-Linux_x86_64/download; \
	unzip $(ZIPBALL); \

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	td=$$(mktemp -d); \
	rm -rf "$${td}"; \
	cp -p -R "$(BUILD_PATH)" "$${td}"; \
	cd "$${td}"; \
	mapfile -t files < <(find . -type f -executable); \
	for ff in "$${files[@]}"; do \
	    sed -i -E "s/^(#[[:space:]]*\!\/usr\/bin\/env[[:space:]]+python)([[:space:]]|$$)/\12\2/g" "$${ff}"; \
	done; \
	mv "$${td}" "$(BUILD_PATH)/.patched"; \
	rm -rf "$${td}"
	diff -u -w "$(BUILD_PATH)" "$(BUILD_PATH)/.patched" || true
	touch "$(BUILD_PATH)/.patched/done"


$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p "$(PREFIX)"
	chmod -R u+w "$(PREFIX)"
	rm -rf "$(PREFIX)"
	mkdir -p "$(PREFIX)"
	cp -R "$(BUILD_PATH)/.patched" "$(BUILD_PATH)/$(BUILD_NAME)"
	cp -R "$(BUILD_PATH)/$(BUILD_NAME)" "$(PREFIX)/.."
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

