include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).tar.bz2
GITHUB_REPO=https://raw.githubusercontent.com/samtools/bcftools

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/samtools/$(NAME)/releases/download/$(VERSION)/$(TARBALL); \
	tar jxf $(TARBALL)

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	td=$$(mktemp -d); \
	rm -rf "$${td}"; \
	cp -p -R "$(BUILD_PATH)" "$${td}"; \
	cd "$${td}"; \
	mapfile -t files < <(find . -type f -executable); \
	for ff in "$${files[@]}"; do \
	    sed -i -E "s/^(#[[:space:]]*\!\/usr\/bin\/env[[:space:]]+python)([[:space:]]|$$)/\13\2/g" "$${ff}"; \
	done; \
	mv "$${td}" "$(BUILD_PATH)/.patched"; \
	rm -rf "$${td}"
	diff -u -w "$(BUILD_PATH)" "$(BUILD_PATH)/.patched" || true
	touch "$(BUILD_PATH)/.patched/done"


$(INSTALL_TARGET): $(BUILD_TARGET)
	make --quiet pre_install
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH)/.patched; \
	if ! module try-load $(CONFIG_MODULES) 2> /dev/null; then \
	    >&2 echo "ERROR: Failed to load module '$(CONFIG_MODULES)'"; \
	    exit 1; \
	fi; \
	make --quiet install
	make --quiet post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent $(GITHUB_REPO)/develop/NEWS | grep -E "^#+ Release [[:digit:]]" | head -1 | sed -E 's/(^#+ Release *| .*)//g'
