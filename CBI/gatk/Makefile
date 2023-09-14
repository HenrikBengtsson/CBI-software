include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).zip
GITHUB_REPO=https://github.com/broadinstitute/gatk
URL=$(GITHUB_REPO)/releases/download/$(VERSION)/$(TARBALL)

ifeq ($(VERSION_X),1)
TARBALL=GenomeAnalysisTK-$(VERSION).tar.bz2
URL=ftp://ftp.broadinstitute.org/pub/gsa/GenomeAnalysisTK/$(TARBALL)
DOWNLOAD_TARGET_FILE=GenomeAnalysisTK.jar
INSTALL_TARGET_FILE=GenomeAnalysisTK.jar
endif

include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
ifeq ($(VERSION_X),1)
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O "$(URL)"; \
	tar jxf "$(TARBALL)"; \
	mv "GenomeAnalysisTK-$(VERSION)" "$(BUILD_PATH)"
else
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -J -L -o "$(TARBALL)" "$(URL)"; \
	unzip "$(TARBALL)"; \
	if [[ -d "gatk-protected-$(VERSION)" ]]; then mv "gatk-protected-$(VERSION)" "$(BUILD_NAME)"; fi
endif


## Patch code: 'python' -> 'python3'
$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	td=$$(mktemp -d); \
	rm -rf "$${td}"; \
	cp -p -R "$(BUILD_PATH)" "$${td}"; \
	cd "$${td}"; \
	mapfile -t files < <(find . -type f -executable); \
	for ff in "$${files[@]}"; do \
	    echo "$ff"; \
	    sed -i -E "s/^(python)[[:space:]]+/\13 /g" "$${ff}"; \
	    sed -i -E "s/^(#[[:space:]]*\!\/usr\/bin\/env[[:space:]]+python)([[:space:]]|$$)/\13\2/g" "$${ff}"; \
	done; \
	mv "$${td}" "$(BUILD_PATH)/.patched"; \
	rm -rf "$${td}"
	diff -u -w "$(BUILD_PATH)" "$(BUILD_PATH)/.patched" || true
	touch "$(BUILD_PATH)/.patched/done"


$(INSTALL_TARGET): $(BUILD_TARGET)
	echo cp -R "$(BUILD_PATH)/.patched" "$$(dirname "$(PREFIX)")"
	cp -R "$(BUILD_PATH)/.patched" "$$(dirname "$(PREFIX)")"
	mv "$$(dirname "$(PREFIX)")/.patched" "$(PREFIX)"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
