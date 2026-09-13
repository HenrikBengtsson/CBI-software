include config.mk
include ../utils.mk

GITHUB_REPO=https://github.com/$(NAME)/$(NAME)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(INSTALL_TARGET):
	make --quiet assert_version
	make --quiet pre_install
	mkdir -p $(BUILD_PATH)
	module purge; \
	module try-load $(BUILD_MODULES); \
	module list; \
	uv_dir="$${UV_PYTHON_INSTALL_DIR:-$(BUILD_PATH)}"; \
	UV_PYTHON_INSTALL_DIR="$${uv_dir}" uv python install --no-bin $(PYTHON_VERSION); \
	mkdir -p "$(PREFIX)/python"; \
	cp -pR "$${uv_dir}"/cpython-$(PYTHON_VERSION)*/* "$(PREFIX)/python/"; \
	"$(PREFIX)/python/bin/python3" -m venv "$(PREFIX)/venv"; \
	uv pip install --python "$(PREFIX)/venv" $(NAME)==$(VERSION) $(if $(SNAKEMAKE_EXECUTOR),$(patsubst %,snakemake-executor-plugin-%,$(SNAKEMAKE_EXECUTOR))); \
	mkdir -p "$(PREFIX)/bin"; \
	ln -fs $(PREFIX)/venv/bin/snakemake $(PREFIX)/bin/
	make post_install
	ls -la "$(PREFIX)"
	ls -la "$(PREFIX)/bin"
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

post_install:
	rm -f "$(PREFIX)"/python/lib/python*/lib-dynload/_tkinter*.so
	find "$(PREFIX)" -name "rot_13.py" -exec chmod a-x {} +
	make --quiet write_protect_install

available-version:
	@make --quiet available-version-github
