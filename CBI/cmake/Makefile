include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
ARCH=linux-x86_64
ifeq ($(VERSION_X), 2)
    ARCH=Linux-x86_64
else ifeq ($(shell test "$(VERSION_Y)" -lt 20; echo $$?), 0)
    ARCH=Linux-x86_64
endif

TARBALL=$(NAME)-$(VERSION)-$(ARCH).tar.gz

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl --insecure -L -O https://github.com/Kitware/CMake/releases/download/v$(VERSION)/$(TARBALL); \
	tar xfz $(TARBALL); \
	mv $(NAME)-$(VERSION)-$(ARCH) $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -R "$(DOWNLOAD_PATH)" "$(SOFTWARE_HOME)"
