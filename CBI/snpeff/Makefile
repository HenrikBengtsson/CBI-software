include config.mk
include ../utils.mk

VERSION_:=$(subst .,_,$(VERSION))

ZIPBALL=$(NAME)_v$(VERSION_)_core.zip
DOWNLOAD_URL=https://snpeff.odsp.astrazeneca.com/versions/$(ZIPBALL)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME)/$(NAME)-$(VERSION)
	cd $(BUILD_HOME)/$(NAME)-$(VERSION); \
	curl -J -L -O $(DOWNLOAD_URL); \
	unzip $(ZIPBALL); \
	rm $(ZIPBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -pR $(BUILD_HOME)/$(NAME)-$(VERSION) $(SOFTWARE_HOME)
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@pattern="^v([[:digit:]]+[.][[:digit:]]+(|[[:alpha:]]))[[:space:]]*"; \
	curl --silent https://github.com/pcingola/SnpEff/tags | pandoc --from=html --to=plain | grep -E "$$pattern" | head -1 | sed -E "s/$$pattern/\1/" 
