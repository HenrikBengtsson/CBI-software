include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION)-bin.tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://www.apache.org/dist/ant/binaries/$(TARBALL); \
	tar xf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

changelog-latest:
	@curl --silent "https://downloads.apache.org/ant/binaries/?C=M;O=D" | pandoc --from=html --to=plain | grep -F "apache-ant-" | head -n 1 | sed -E 's/^ +//g'

available-version:
	@curl --silent "https://downloads.apache.org/ant/binaries/?C=M;O=D" | pandoc --from=html --to=plain | grep -F "apache-ant-" | head -n 1 | sed -E 's/(^ *apache-ant-|-bin.*)//g'
