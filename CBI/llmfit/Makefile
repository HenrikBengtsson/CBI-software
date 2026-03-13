include config.mk
include ../utils.mk

TARBALL=$(VERSION).tar.gz

GITHUB_REPO=https://github.com/AlexsJones/llmfit

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	git clone $(GITHUB_REPO).git; \
	mv $(NAME) $(NAME)-$(VERSION)

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	module try-load $(BUILD_MODULES); \
	cd $(BUILD_PATH); \
	git checkout v$(VERSION); \
	cargo build --release

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p "$(PREFIX)"
	cp -p "$(BUILD_TARGET)" "$(PREFIX)"
	ls -al "$(PREFIX)"

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//'
