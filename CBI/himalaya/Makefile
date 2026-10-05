include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/pimalaya/himalaya

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(BUILD_TARGET):
	mkdir -p $(BUILD_PATH)
	module try-load $(BUILD_MODULES); \
	cargo install --locked --root=$(BUILD_PATH) --version=$(VERSION) $(NAME)

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p "$(PREFIX)/bin"
	cp -p "$(BUILD_TARGET)" "$(PREFIX)/bin"
	ls -al "$(PREFIX)/bin"
