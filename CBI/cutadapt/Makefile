include config.mk
include ../utils.mk

## Based on the official instructions in Section 'Shared installation (on a cluster)'
## of the 'Installation' document
## https://github.com/marcelm/cutadapt/blob/main/doc/installation.rst
$(INSTALL_TARGET):
	module purge; \
	module list; \
	mkdir -p "$(PREFIX)/bin"; \
	virtualenv "$(PREFIX)/venv"; \
	"$(PREFIX)/venv/bin/python" -m pip install --upgrade pip; \
	"$(PREFIX)/venv/bin/pip" install $(NAME)==$(VERSION); \
	cd "$(PREFIX)/bin"; \
	ln -s ../venv/bin/cutadapt .
	ls -la "$(PREFIX)"
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"
