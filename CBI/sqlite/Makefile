include config.mk
include ../utils.mk


TARNAME=$(NAME)-autoconf-$(VERSION_ID)
TARBALL=$(TARNAME).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://www.sqlite.org/$(VERSION_YEAR)/$(TARBALL); \
	tar xfz $(TARBALL); \
	mv $(TARNAME) $(NAME)-$(VERSION)
	ls -la "$(BUILD_PATH)"
	grep -q -E "^[[:space:]]*VERSION='?$(VERSION)'?" $(DOWNLOAD_TARGET) || { 1>&2 echo "VERSION $(VERSION) != $$(cat "$(BUILD_PATH)/VERSION")"; exit 1; }

$(BUILD_PATH)/check.log:
	cd $(BUILD_PATH); \
	module --force purge; \
	module load $(BUILD_MODULES); \
	module list; \
	make test &> check.log

#post_build: $(BUILD_PATH)/check.log

available-version:
	@curl --silent https://github.com/sqlite/sqlite/tags | pandoc --from=html --to=plain | grep -E "^[[:space:]]+Version " | head -1 | sed -E 's/[[:space:]]+Version //'
