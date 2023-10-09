include config.mk
include ../utils.mk

ifeq ($(LINUX_NAME),Ubuntu)
  ARCH=linux-amd64
else
  ARCH=linux-rhel7-amd64
endif
TARBALL=$(NAME)-$(VERSION)-$(ARCH).tar.gz
GITHUB_REPO=https://github.com/quarto-dev/quarto-cli

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar -xzf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"/..
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	## PATCH for bug https://github.com/quarto-dev/quarto-cli/issues/7024
	chmod u+w "$(PREFIX)/share/formats/html/pandoc/template.html"
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*v//'
