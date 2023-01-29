include config.mk
include ../utils.mk

ZIPNAME=$(NAME)-v$(VERSION)-linux-amd64
ZIPFILE=$(ZIPNAME).zip
GITHUB_REPO=https://github.com/rclone/rclone

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O https://downloads.rclone.org/v$(VERSION)/$(ZIPFILE); \
	unzip $(ZIPFILE); \
	mv $(ZIPNAME) $(BUILD_NAME)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

post_install:
	mkdir -p $(PREFIX)/share/man/man1
	mv $(PREFIX)/*.1 $(PREFIX)/share/man/man1

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
