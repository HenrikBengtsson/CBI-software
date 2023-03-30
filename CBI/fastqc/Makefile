include config.mk
include ../utils.mk


ZIPFILE=fastqc_v$(VERSION).zip

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
        curl -O https://www.bioinformatics.babraham.ac.uk/projects/fastqc/$(ZIPFILE); \
	unzip $(ZIPFILE); \
	mv $(NAME) $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	chmod ugo+x $(BUILD_PATH)/fastqc
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@pattern=".*FastQC[[:space:]]+v([[:digit:]]+[.][[:digit:]]+[.][[:digit:]]+).*"; \
	curl --silent https://raw.githubusercontent.com/s-andrews/FastQC/master/RELEASE_NOTES.txt | grep -E "$$pattern" | head -1 | sed -E "s/$$pattern/\1/"
