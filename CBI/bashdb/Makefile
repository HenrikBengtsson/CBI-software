include config.mk
include ../utils.mk

TARBALL=$(NAME)-$(VERSION).tar.gz


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://downloads.sourceforge.net/project/bashdb/$(NAME)/$(VERSION)/$(TARBALL); \
	tar zxf $(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent https://sourceforge.net/projects/bashdb/files/bashdb/ | pandoc --from=html --to=plain | grep -A 50 -E "Home */ *bashdb" | grep -E "[^[:digit:]]*\b([[:digit:].-]+)\b.*" | sed -E 's/[^[:digit:]]*\b([[:digit:].-]+)\b.*/\1/g' | sort -r -h | grep -E "^4" | head -1

