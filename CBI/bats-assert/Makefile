include config.mk
include ../utils.mk

TARBALL=v$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/bats-core/$(NAME)/archive/$(TARBALL); \
	tar zxf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -R $(BUILD_PATH) $(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

changelog-latest:
	@curl --silent https://raw.githubusercontent.com/bats-core/bats-assert/master/package.json | grep -E '"(name|version)":' | sed -E 's/^ +//g' | tr $$'\n' ' '
	@echo
