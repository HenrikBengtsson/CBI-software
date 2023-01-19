include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).tar.bz2

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/samtools/$(NAME)/releases/download/$(VERSION)/$(TARBALL); \
	tar jxf $(TARBALL)

available-version:
	@curl --silent https://raw.githubusercontent.com/samtools/bcftools/develop/NEWS | grep -E "^#+ Release [[:digit:]]" | head -1 | sed -E 's/(^#+ Release *| .*)//g'
