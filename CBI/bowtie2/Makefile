include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION)-linux-x86_64.zip
GITHUB_REPO=https://github.com/BenLangmead/bowtie2

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	unzip $(TARBALL); \
	mv $(NAME)-$(VERSION)-linux-x86_64 $(NAME)-$(VERSION)

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
	make --quiet pre_install
	mkdir -p $(PREFIX)
	cp -pR $(BUILD_PATH)/.patched/* "$(PREFIX)"
	rm "$(PREFIX)"/done
	make --quiet post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
