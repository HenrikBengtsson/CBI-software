include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).Linux_x86_64.tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O http://ccb.jhu.edu/software/tophat/downloads/$(TARBALL); \
	tar zxf $(TARBALL); \
	mv $(NAME)-$(VERSION).Linux_x86_64 $(NAME)-$(VERSION)

## Patch code: 'python' -> 'python2'
$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	td=$$(mktemp -d); \
	rm -rf "$${td}"; \
	cp -p -R "$(BUILD_PATH)" "$${td}"; \
	cd "$${td}"; \
	mapfile -t files < <(find . -type f -executable); \
	for ff in "$${files[@]}"; do \
	    sed -i -E "s/^python[[:space:]]+/python2 /g" "$${ff}"; \
	    sed -i -E "s/^(#[[:space:]]*\!\/usr\/bin\/env[[:space:]]+python)([[:space:]]|$$)/\12\2/g" "$${ff}"; \
	done; \
	mv "$${td}" "$(BUILD_PATH)/.patched"; \
	rm -rf "$${td}"
	diff -u -w "$(BUILD_PATH)" "$(BUILD_PATH)/.patched" || true
	touch "$(BUILD_PATH)/.patched/done"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	chmod -R u+w "$(PREFIX)"
	rm -rf "$(PREFIX)"
	mkdir -p "$(PREFIX)"
	cp -R "$(BUILD_PATH)/.patched" "$(BUILD_PATH)/$(BUILD_NAME)"
	cp -R "$(BUILD_PATH)/$(BUILD_NAME)" "$(PREFIX)/.."
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
