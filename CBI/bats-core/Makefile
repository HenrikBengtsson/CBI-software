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
	$(BUILD_PATH)/install.sh $(PREFIX)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://raw.githubusercontent.com/bats-core/$(NAME)/master/package.json | grep -A 1 -E '"name": * "bats"' | grep -E '"version":' | sed -E 's/.*://' | sed -E 's/(^ *"|".*)//g'
