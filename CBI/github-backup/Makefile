include config.mk
include ../utils.mk

ARCH=linux_amd64
TARNAME=gh_$(VERSION)_$(ARCH)
TARBALL=$(TARNAME).tar.gz

GITHUB_OWNER=SierraSoftworks
GITHUB_REPONAME=$(NAME)
GITHUB_REPO=https://github.com/$(GITHUB_OWNER)/$(GITHUB_REPONAME)

ARCH=linux-amd64
TARNAME=$(NAME)-$(ARCH)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARNAME); \
	mv "$(TARNAME)" "$(NAME)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -R $(BUILD_PATH) "$$(dirname "$(PREFIX)")"
	chmod ugo+x "$(PREFIX)/$(NAME)"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent "https://api.github.com/repos/$(GITHUB_OWNER)/$(GITHUB_REPONAME)/tags" | grep -E '"name":' | sed -E 's/(.* |"|,)//g' | grep -E "^[[:digit:].]+$$" | head -n 1


	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
