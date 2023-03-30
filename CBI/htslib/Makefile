#' Example:
#' make VERSION=2.2.0

include config.mk
include ../utils.mk


TARBALL=$(NAME)-$(VERSION).tar.bz2
GITHUB_REPO=https://github.com/samtools/samtools

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/$(VERSION)/$(TARBALL); \
	tar jxf $(TARBALL)

available-version:
	@curl --silent $(GITHUB_REPO)/develop/NEWS | grep -E "^Release [[:digit:]]" | head -1 | sed -E 's/(^Release *| .*)//g'


