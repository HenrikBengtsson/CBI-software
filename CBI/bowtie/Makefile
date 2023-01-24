include config.mk
include ../utils.mk

ZIPFILE=$(NAME)-$(VERSION)-linux-x86_64.zip


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://sourceforge.net/projects/bowtie-bio/files/$(NAME)/$(VERSION)/$(ZIPFILE); \
	unzip $(ZIPFILE); \
	mv $(NAME)-$(VERSION)-linux-x86_64 $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://bowtie-bio.sourceforge.net/index.shtml | grep -F "https://sourceforge.net/projects/bowtie-bio/files/bowtie/" | sed -E 's#(^.*https://sourceforge.net/projects/bowtie-bio/files/bowtie/|".*)##g'
