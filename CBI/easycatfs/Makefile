include config.mk
include ../utils.mk

TARBALL=$(VERSION).tar.gz

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://github.com/HenrikBengtsson/easycatfs/archive/refs/tags/$(TARBALL); \
	tar xzf $(TARBALL)

## For now, we install customized 'catfs' devel with 'easycatfs' /HB 2022-01-19
$(BUILD_PATH)/bin/catfs:
	if [[ -f "catfs" ]]; then \
	    cp catfs "$(BUILD_PATH)/bin"; \
	else \
	    cd $(BUILD_PATH); \
	    git clone --depth=1 --branch=fewerthreads https://github.com/HenrikBengtsson/catfs.git; \
	    cargo install --root=$(BUILD_PATH) --path=catfs; \
	fi
	"$@" --version

post-build: $(BUILD_PATH)/bin/catfs

$(BUILD_TARGET): $(DOWNLOAD_TARGET) $(BUILD_PATH)/bin/catfs

$(INSTALL_TARGET):
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH); \
	cp -p README.md NEWS.md $(PREFIX); \
	cp -pR bin/ $(PREFIX)
