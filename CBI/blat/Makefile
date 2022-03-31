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
	cp -pR $(BUILD_PATH) $(SOFTWARE_HOME)
	touch $(PREFIX)/*  ## workaround for time discrepancies
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
