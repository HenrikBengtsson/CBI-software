include config.mk
include ../utils.mk

ZIPBALL=$(NAME)_$(VERSION).zip
GITHUB_REPO=https://github.com/igvteam/igv

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)
	cd $(BUILD_HOME); \
	curl -L -O https://data.broadinstitute.org/igv/projects/downloads/$(VERSION_X_Y)/$(ZIPBALL); \
	unzip $(ZIPBALL); \
	mv $(NAME)_$(VERSION) $(NAME)-$(VERSION); \

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -pR $(BUILD_HOME)/$(NAME)-$(VERSION) $(SOFTWARE_HOME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@pattern="^v([[:digit:]]+[.][[:digit:]]+[.][[:digit:]]+)[[:space:]]*"; \
	curl --silent "$(GITHUB_REPO)/tags" | pandoc --from=html --to=plain | grep -E "$$pattern" | head -1 | sed -E "s/$$pattern/\1/"
