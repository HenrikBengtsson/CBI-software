include config.mk
include ../utils.mk


ARCH=linux-x86_64
TARBALL=$(NAME)-$(VERSION)-$(ARCH).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH)
	cd $(BUILD_PATH); \
	curl -L -O https://dev.yorhel.nl/download/$(TARBALL); \
	tar xf "$(TARBALL)"

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)"
	cp "$(BUILD_PATH)/$(NAME)" "$(PREFIX)"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent -L https://dev.yorhel.nl/ncdu/changes2 | pandoc -f html -t plain | grep "[.]tar[.]gz" | sed -E 's/(.* *ncdu-|[.]tar[.]gz.*)//g' | head -1
