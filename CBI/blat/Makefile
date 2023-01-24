include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH)
	cd $(BUILD_PATH); \
	curl -O http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/blat/gfClient; \
	curl -O http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/blat/gfServer; \
	curl -O http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/blat/blat; \
	chmod ugo+x blat gfClient gfServer

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -R $(BUILD_PATH) $(SOFTWARE_HOME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/blat/ | grep -E "blat.*BLAT[[:space:]]+v" | sed -E 's/blat.*BLAT[[:space:]]+v[^[:space:]]*[[:space:]]+([^[:space:]]+)[[:space:]]+.*/\1/g'
