include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
PYTHON3=python3

## Installs the 'globus' command-line tool from the 'globus-cli' PyPI
## package into a dedicated Python virtual environment.
## https://docs.globus.org/cli/installation/
$(INSTALL_TARGET):
	make --quiet assert_version
	make --quiet pre_install
	module purge; \
	module load CBI; \
	module list; \
	mkdir -p "$(PREFIX)"; \
	$(PYTHON3) -m venv "$(PREFIX)"; \
	. "$(PREFIX)/bin/activate"; \
	python --version; \
	python -m pip install --upgrade pip; \
	python -m pip install $(NAME)==$(VERSION)
	ls -la "$(PREFIX)"
	ls -la "$(PREFIX)/bin"
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@python3 -m pip index versions $(NAME) 2>1 | head -n 1 | sed -E 's/(.*[(]|[)])//g'
