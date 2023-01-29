include config.mk
include ../utils.mk

TARBALL=$(NAME)_linux-v$(VERSION).tar.gz
GITHUB_REPO=https://github.com/pachterlab/kallisto

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar zxf $(TARBALL); \
	mv $(NAME) $(NAME)-$(VERSION)                   # 0.46.0
#	mv $(NAME)_linux-v$(VERSION) $(NAME)-$(VERSION) # 0.45.x

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
