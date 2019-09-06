include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	cp -R $(PWD)/src $(DOWNLOAD_PATH)
	ls -la $(DOWNLOAD_PATH)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	echo cp -R $(<D)/* $(PREFIX)/
	cp -R $(<D)/* $(PREFIX)/
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

cleanup:
	rm -rf -- $(DOWNLOAD_PATH)
