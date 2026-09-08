include config.mk
include ../utils.mk

## Illumina retired its anonymous FTP server (ussd-ftp.illumina.com) and now
## distributes bcl2fastq only through an EULA-gated download page that hands
## out a per-browser-session URL, which cannot be scripted (same situation as
## cellranger).  The user must therefore download the source archive manually
## and place it in this directory.  An Illumina account (sign-in) is required,
## and signing in requires accepting the Illumina Software Subscription
## Agreement:
## https://www.illumina.com/content/dam/illumina-marketing/documents/terms-conditions/united-states/illumina-software-subscription-agreement.pdf
TARBALL=$(NAME)2-v$(subst .,-,$(VERSION))-tar.zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(TARBALL):
	$(error Cannot auto-download $(NAME) $(VERSION). Go to https://support.illumina.com/sequencing/sequencing_software/bcl2fastq-conversion-software/downloads.html, sign in (which requires accepting the Illumina Software Subscription Agreement <https://www.illumina.com/content/dam/illumina-marketing/documents/terms-conditions/united-states/illumina-software-subscription-agreement.pdf>), accept the EULA, and download "bcl2fastq2 Conversion Software v$(VERSION)" as the *Source* archive (the "tar" download, not the rpm). Save '$@' to $(PWD))

$(DOWNLOAD_TARGET): $(TARBALL)
	mkdir -p $(BUILD_HOME)
	cp -p "$(TARBALL)" "$(BUILD_HOME)/"
	cd $(BUILD_HOME); \
	unzip -o $(TARBALL); \
	tar vxf $(NAME)2-v$(VERSION).*-Source.tar.gz; \
	rm -rf "$(BUILD_PATH)"; \
	mv $(NAME) $(BUILD_PATH)
	touch $(DOWNLOAD_TARGET)

$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	mkdir bcl2fastq-build; \
	cd bcl2fastq-build; \
	module --force purge; \
	../src/configure $(CONFIG_OPTS) --prefix=$(PREFIX)

$(BUILD_TARGET): $(CONFIG_TARGET)
	cd $(BUILD_PATH)/bcl2fastq-build; \
	module --force purge; \
	make $(BUILD_OPTS); \
	make post_build

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(SOFTWARE_HOME)
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH)/bcl2fastq-build; \
	make install
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"


available-version:
	@curl --silent https://support.illumina.com/sequencing/sequencing_software/bcl2fastq-conversion-software/downloads.html | pandoc --from=html --to=plain | grep -E "^- +$(NAME).? Conversion Software v.*" | head -1 | sed -E 's/.*v([[:digit:].]+).*$$/\1/g'
