include config.mk
include ../utils.mk

GITHUB_OWNER=andreafrancia
GITHUB_REPONAME=$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
PYTHON3=python3

## Hide 'python' from PATH
post_install:
	rm -f "$(PREFIX)"/bin/activate* "$(PREFIX)"/bin/Activate*
	rm -f "$(PREFIX)"/bin/pip*
	ln -sfn "$$(readlink -f "$(PREFIX)"/bin/python)" "$(PREFIX)"/bin/.python3
	rm -f "$(PREFIX)"/bin/python "$(PREFIX)"/bin/python?*
	sed -i -E 's|/bin/python$$|/bin/.python3|' "$(PREFIX)"/bin/trash*

$(INSTALL_TARGET):
	module purge; \
	module load CBI; \
	module list; \
	mkdir -p "$(PREFIX)"; \
	$(PYTHON3) -m venv "$(PREFIX)"; \
	. "$(PREFIX)/bin/activate"; \
	python --version; \
	python -m pip install --upgrade pip; \
	python -m pip install trash-cli==$(VERSION)
	make post_install
	ls -la "$(PREFIX)"
	ls -la "$(PREFIX)/bin"
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	@curl --silent "https://api.github.com/repos/$(GITHUB_OWNER)/$(GITHUB_REPONAME)/tags" | grep -E '"name":' | sed -E 's/(.* |"|,)//g' | grep -E "^[[:digit:].]+$$" | head -n 1

