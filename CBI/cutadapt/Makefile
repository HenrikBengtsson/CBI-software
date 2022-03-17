include config.mk
include ../utils.mk

## Based on the official instructions in Section 'Shared installation (on a cluster)'
## of the 'Installation' document
## https://github.com/marcelm/cutadapt/blob/main/doc/installation.rst
$(INSTALL_TARGET):
	module purge; \
	module load CBI; \
	module list; \
	mkdir -p "$(PREFIX)/bin"; \
	virtualenv -p python3 "$(PREFIX)/venv"; \
	. "$(PREFIX)/venv/bin/activate"; \
	python --version; \
	python -m pip install --upgrade pip; \
	python -m pip install $(NAME)==$(VERSION)
	ln -fs $(PREFIX)/venv/bin/cutadapt $(PREFIX)/bin/
	ls -la "$(PREFIX)"
	ls -la "$(PREFIX)/bin"
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
