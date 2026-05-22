include config.mk
include ../utils.mk

ARCH=linux-amd64
TARBALL=$(NAME)-$(ARCH).tar.bz2

GITHUB_REPO=https://github.com/microsoft/go-sqlcmd

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -o firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US"; \
	tar xf "firefox.tar.bz2"; \
	mv firefox/ "$(NAME)-$(VERSION)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	version=$$($(BUILD_PATH)/firefox --version 2> /dev/null | sed -E 's/.* //'); \
	if [[ "$${version}" != "$(VERSION)" ]]; then \
	  echo "Installed version $${version} is not the requested version $(VERSION)"; \
	  exit 1; \
	fi
	mkdir -p "$(PREFIX)/.."
	cp -p -R "$(BUILD_PATH)" "$(PREFIX)/.."
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent --head https://www.firefox.com/en-US/firefox/notes/?redirect_source=mozilla-org | grep -E "^location:" | sed -E 's#(.*firefox/|/.*)##g' 


