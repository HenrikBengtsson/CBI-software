include config.mk
include ../utils.mk

ARCH=amd64
TARBALL=$(NAME)_$(VERSION)_$(ARCH).deb
GITHUB_OWNER=yuezk
GITHUB_REPO=$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH)
	cd $(BUILD_PATH); \
	curl -L -O https://github.com/$(GITHUB_OWNER)/$(GITHUB_REPO)/releases/download/v$(VERSION_X_Y_Z)/$(TARBALL)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	sudo dpkg --install "$(TARBALL)"
	gpclient --version

$(INSTALL_MODULE):
	echo "No a module"
	exit 1

available-version:
	curl --head --silent "https://github.com/$(GITHUB_OWNER)/$(GITHUB_REPO)/releases/latest" | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'

