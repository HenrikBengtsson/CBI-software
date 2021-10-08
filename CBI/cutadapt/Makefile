include config.mk
include ../utils.mk

## Based on the official instructions in Section 'Shared installation (on a cluster)'
## of the 'Installation' document
## https://github.com/marcelm/cutadapt/blob/main/doc/installation.rst
$(INSTALL_TARGET):
	module purge; \
	module load CBI; \
	module load python/2.7.15 2> /dev/null || true; \
	python --version; \
	module list; \
	mkdir -p "$(PREFIX)/bin"; \
	virtualenv "$(PREFIX)/venv"; \
	. "$(PREFIX)/venv/bin/activate"; \
	python -m pip install --upgrade pip; \
	python -m pip install $(NAME)==$(VERSION)
	ln -fs $(PREFIX)/venv/bin/cutadapt $(PREFIX)/bin/
	ls -la "$(PREFIX)"
	ls -la "$(PREFIX)/bin"
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
