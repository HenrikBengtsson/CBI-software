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

GITHUB_REPO=https://github.com/Kitware/CMake

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl --insecure -L -O $(GITHUB_REPO)/releases/download/v$(VERSION)/$(TARBALL); \
	tar xfz $(TARBALL); \
	mv $(NAME)-$(VERSION)-$(ARCH) $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cp -R "$(DOWNLOAD_PATH)" "$(SOFTWARE_HOME)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
