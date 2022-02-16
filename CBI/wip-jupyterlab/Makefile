include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(BUILD_TARGET):
	cd $(BUILD_HOME); \
	virtualenv -p python $(NAME)-$(VERSION)
	command -v python
	cd $(BUILD_PATH); \
	. bin/activate; \
	command -v python; \
	python -m pip install --force --upgrade pip; \
	python -m pip --version; \
	python -m pip install $(NAME)==$(VERSION)

$(INSTALL_TARGET): $(BUILD_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
