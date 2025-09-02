include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(BUILD_PATH)/virtualenv:
	module load CBI; \
	python3 -m pip install --target="$(@D)" virtualenv pip

post_install:
	rm -f "$(PREFIX)"/bin/activate*
	rm -f "$(PREFIX)"/bin/pip*
#	rm -f "$(PREFIX)"/bin/python?*

$(INSTALL_TARGET): $(BUILD_PATH)/virtualenv
	module purge; \
	module load CBI; \
	module list; \
	mkdir -p "$(PREFIX)"; \
	$(BUILD_PATH)/bin/virtualenv -p python3 "$(PREFIX)"; \
	. "$(PREFIX)/bin/activate"; \
	python --version; \
	python -m pip install --upgrade pip; \
	python -m pip install trash-cli==$(VERSION)
	make post_install
	ls -la "$(PREFIX)"
	ls -la "$(PREFIX)/bin"
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
