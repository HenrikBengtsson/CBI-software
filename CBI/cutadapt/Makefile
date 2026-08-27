include config.mk
include ../utils.mk

PYTHON3=python3

ifeq ($(LINUX_NAME),CentOS Linux)
PYTHON3=python3
else ifeq ($(_LINUX_DISTRO_),rocky8)
PYTHON3=python3.11
else ifeq ($(_LINUX_DISTRO_),rocky9)
PYTHON3=python3
endif


debug2:
	@echo "PYTHON3=$(PYTHON3)"

## Based on the official instructions in Section 'Shared installation (on a cluster)'
## of the 'Installation' document
## https://github.com/marcelm/cutadapt/blob/main/doc/installation.rst
$(INSTALL_TARGET):
	module purge; \
	module load CBI; \
	module list; \
	mkdir -p "$(PREFIX)/bin"; \
	$(PYTHON3) -m venv "$(PREFIX)/venv"; \
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
	curl --silent https://raw.githubusercontent.com/marcelm/cutadapt/main/CHANGES.rst | grep -E "$$pattern" | head -1 | sed -E "s/$$pattern/\1/"
