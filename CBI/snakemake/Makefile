include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/$(NAME)/$(NAME)
PYTHON3=python3

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(INSTALL_TARGET):
	make --quiet assert_version
	make --quiet pre_install
	module purge; \
	module load CBI; \
	module list; \
	mkdir -p "$(PREFIX)/bin"; \
	$(PYTHON3) -m venv "$(PREFIX)/venv"; \
	. "$(PREFIX)/venv/bin/activate"; \
	python --version; \
	python -m pip install --upgrade pip; \
	python -m pip install $(NAME)==$(VERSION); \
	ln -fs $(PREFIX)/venv/bin/snakemake $(PREFIX)/bin/
	make post_install
	ls -la "$(PREFIX)"
	ls -la "$(PREFIX)/bin"
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@make --quiet available-version-github
