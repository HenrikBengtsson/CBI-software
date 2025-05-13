include config.mk
include ../utils.mk

ARCH=linux-x86_64
TARBALL=$(NAME)-$(VERSION)-$(ARCH).tar.gz

GITHUB_REPO=https://github.com/JuliaLang/julia

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://julialang-s3.julialang.org/bin/linux/x64/$(VERSION_X_Y)/$(TARBALL); \
	tar xf "$(TARBALL)"

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
