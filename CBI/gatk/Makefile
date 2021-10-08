include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).zip
URL=https://github.com/broadinstitute/gatk/releases/download/$(VERSION)/$(TARBALL)

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


$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
