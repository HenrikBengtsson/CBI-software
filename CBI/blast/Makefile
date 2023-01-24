include config.mk
include ../utils.mk

TARBALL=ncbi-$(NAME)-$(VERSION)+-x64-linux.tar.gz


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/$(VERSION)/$(TARBALL); \
	tar -zxf $(TARBALL); \
	mv ncbi-$(NAME)-$(VERSION)+ $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(SOFTWARE_HOME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://www.ncbi.nlm.nih.gov/books/NBK131777/ | pandoc --from=html --to=plain | grep -A 200 -F "BLAST+ Release Notes" | grep -E "^[[:space:]]*BLAST[+][[:space:]]+[[:digit:].]+:[[:space:]]+" | sed -E 's/^[[:space:]]*BLAST[+][[:space:]]+([[:digit:].]+):[[:space:]]+.*/\1/g' | head -1
