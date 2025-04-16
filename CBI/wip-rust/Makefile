include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/rust-lang/rust
ARCH=x86_64-unknown-linux-gnu
FULLNAME=$(NAME)-$(VERSION)-$(ARCH)
TARBALL=$(FULLNAME).tar.xz


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O https://static.rust-lang.org/dist/$(TARBALL); \
	tar xf $(TARBALL); \
	mv $(FULLNAME) $(NAME)-$(VERSION)

$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	mkdir -p "$(PREFIX)/.."
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
