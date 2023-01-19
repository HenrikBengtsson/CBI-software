include config.mk
include ../utils.mk

TARBALL=v$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/statgen/$(NAME)/archive/$(TARBALL); \
	tar -xzf $(TARBALL)

$(BUILD_TARGET):
	cd $(BUILD_PATH); \
	module --force purge; \
	make cloneLib; \
	make

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH); \
	module --force purge; \
	make install INSTALLDIR=$(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

changelog-latest:
	@curl --silent https://genome.sph.umich.edu/wiki/BamUtil | pandoc --from=html --to=plain | grep -E "BamUtil Version .* Released" | head -1

available-version:
	@curl --silent https://genome.sph.umich.edu/wiki/BamUtil | pandoc --from=html --to=plain | grep -E "BamUtil Version .* Released" | head -1 | sed -E 's/.*BamUtil Version ([[:digit:].]+).*Released.*/\1/g'
