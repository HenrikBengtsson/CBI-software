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

## For now, we install 'catfs' devel with 'easycatfs' /HB 2022-01-15
$(BUILD_PATH)/bin/catfs:
	if [[ -f "catfs" ]]; then \
	    cp catfs "$(BUILD_PATH)/bin"; \
	else \
	    cd $(BUILD_PATH); \
	    git clone https://github.com/kahing/catfs.git; \
	    cargo install --root=$(BUILD_PATH) --path=catfs; \
	fi

$(BUILD_TARGET): $(DOWNLOAD_TARGET) $(BUILD_PATH)/bin/catfs

$(INSTALL_TARGET):
	mkdir -p $(PREFIX)
	cd $(BUILD_PATH); \
	cp -p README.md NEWS.md $(PREFIX); \
	cp -pR bin/ $(PREFIX)
