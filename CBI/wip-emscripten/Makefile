include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/emscripten-core/emsdk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	git clone "$(GITHUB_REPO)";

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH)/emsdk; \
	./emsdk install "$(VERSION)"

$(INSTALL_TARGET): $(BUILD_TARGET)
	parent=$$(dirname "$(PREFIX)"); \
	mkdir -p "$${parent}"; \
	cp -pR $(BUILD_PATH)/emsdk "$${parent}"; \
	mv "$${parent}/emsdk" "$(PREFIX)";
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent $(GITHUB_REPO)/tags | pandoc --from=html --to=plain | grep -E "^[[:digit:]]+[.][[:digit:]]+[.][[:digit:]]+$$" | head -1 | sed -E 's/[[:space:]]+$(NAME) //'

