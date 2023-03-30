include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/htop-dev/htop

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
ifeq ($(VERSION),2.2.0)
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -O http://hisham.hm/htop/releases/$(VERSION)/$(TARBALL); \
	tar xfz "$(TARBALL)"
else
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L $(GITHUB_REPO)/archive/refs/tags/$(VERSION).tar.gz -o $(TARBALL); \
	tar xfz $(TARBALL)
endif


$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	module --force purge; \
	module load $(CONFIG_MODULES); \
	module list; \
	echo "LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}"; \
	cd $(BUILD_PATH); \
	./autogen.sh && ./configure $(CONFIG_OPTS) --prefix=$(PREFIX)
	make post_config


ifeq ($(VERSION),3.1.0)
post_config:
	cd $(BUILD_PATH); \
	cp '.deps/$$(myhtopplatprogram).Po' .deps/htop.Po
endif

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
