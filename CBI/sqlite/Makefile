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


## NOTES:
## We set CFLAGS="-DSQLITE_ENABLE_COLUMN_METADATA=1 $${CFLAGS}" because [1,2]
## [1] https://www.sqlite.org/compile.html#enable_column_metadata
## [2] https://stackoverflow.com/a/62947251/1072091
$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	make --quiet pre_config
	module --force purge; \
	module load $(CONFIG_MODULES); \
	module list; \
	export CFLAGS="-DSQLITE_ENABLE_COLUMN_METADATA=1 $${CFLAGS}"; \
	echo "LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}"; \
	echo "CFLAGS=$${CFLAGS}"; \
	cd $(BUILD_PATH); \
	./configure $(CONFIG_OPTS) --prefix=$(PREFIX)
	make --quiet post_config

$(BUILD_PATH)/check.log:
	cd $(BUILD_PATH); \
	module --force purge; \
	module load $(BUILD_MODULES); \
	module list; \
	make test &> check.log

#post_build: $(BUILD_PATH)/check.log

available-version:
	@curl --silent https://github.com/sqlite/sqlite/tags | pandoc --from=html --to=plain | grep -E "^[[:space:]]+Version " | head -1 | sed -E 's/[[:space:]]+Version //'
