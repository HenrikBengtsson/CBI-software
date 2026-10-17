include config.mk
include ../utils.mk

ARCH=linux-amd64
GITEA_REPO=https://gitea.com/gitea/tea

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
## 'tea' ships a raw per-platform binary per release, not a tarball
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH)/bin; \
	curl -L -o $(BUILD_PATH)/bin/tea $(GITEA_REPO)/releases/download/v$(VERSION)/tea-$(VERSION)-$(ARCH); \
	chmod +x $(BUILD_PATH)/bin/tea

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -R $(BUILD_PATH) "$$(dirname "$(PREFIX)")"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://gitea.com/api/v1/repos/gitea/tea/releases?limit=1 | jq -r '.[0].tag_name' | sed 's/^v//'
