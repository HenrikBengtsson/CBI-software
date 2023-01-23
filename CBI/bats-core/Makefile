include config.mk
include ../utils.mk

TARBALL=v$(VERSION).tar.gz
GITHUB_REPO=https://github.com/bats-core/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/archive/$(TARBALL); \
	tar zxf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	$(BUILD_PATH)/install.sh $(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -E "^location:" | sed -E 's/.*(v|-|\/)//'
