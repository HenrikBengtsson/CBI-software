include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(BUILD_PATH)/virtualenv:
	module load CBI; \
	python3 -m pip install --target="$(@D)" virtualenv pip

## Based on the official instructions in Section 'Shared installation (on a cluster)'
## of the 'Installation' document
## https://github.com/marcelm/cutadapt/blob/main/doc/installation.rst
$(INSTALL_TARGET): $(BUILD_PATH)/virtualenv
	make --quiet assert_version
	make --quiet pre_install
	module purge; \
	module load CBI; \
	module list; \
	mkdir -p "$(PREFIX)"; \
	$(BUILD_PATH)/bin/virtualenv -p python3 "$(PREFIX)"; \
	. "$(PREFIX)/bin/activate"; \
	python --version; \
	python -m pip install --upgrade pip; \
	python -m pip install awscli==$(VERSION)
#	cd $(PREFIX); ln -fs venv/bin .
	ls -la "$(PREFIX)"
	ls -la "$(PREFIX)/bin"
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@python -m pip index versions awscli 2>1 | head -n 1 | sed -E 's/(.*[(]|[)])//g'
