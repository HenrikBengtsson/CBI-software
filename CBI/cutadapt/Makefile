include config.mk
include ../utils.mk

PYTHON3=python3.8

ifeq ($(LINUX_NAME),CentOS Linux)
PYTHON3=python3
endif


debug2:
	@echo "PYTHON3=$(PYTHON3)"

$(BUILD_PATH)/virtualenv:
	module load CBI; \
	module try-load scl-rh-python/38; \
	$(PYTHON3) -m pip install --target="$(@D)" virtualenv pip

## Based on the official instructions in Section 'Shared installation (on a cluster)'
## of the 'Installation' document
## https://github.com/marcelm/cutadapt/blob/main/doc/installation.rst
$(INSTALL_TARGET): $(BUILD_PATH)/virtualenv
	module purge; \
	module load CBI; \
	module try-load CBI scl-rh-python/38; \
	module list; \
	mkdir -p "$(PREFIX)/bin"; \
	$(BUILD_PATH)/bin/virtualenv -p $(PYTHON3) "$(PREFIX)/venv"; \
	. "$(PREFIX)/venv/bin/activate"; \
	python --version; \
	python -m pip install --upgrade pip; \
	python -m pip install $(NAME)==$(VERSION)
	ln -fs $(PREFIX)/venv/bin/cutadapt $(PREFIX)/bin/
	ls -la "$(PREFIX)"
	ls -la "$(PREFIX)/bin"
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@pattern=".*v([[:digit:]]+[.][[:digit:]]+)[[:space:]].*"; \
	curl --silent https://github.com/marcelm/cutadapt/blob/main/CHANGES.rst | pandoc --from=html --to=plain | grep -A 5 -F "[]Changelog" | grep -E "$$pattern" | sed -E "s/$$pattern/\1/"
