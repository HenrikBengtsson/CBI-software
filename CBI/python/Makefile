include config.mk
include ../utils.mk

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(INSTALL_TARGET):
	mkdir -p $(BUILD_PATH)
	cd $(BUILD_PATH); \
	module purge; \
	module try-load $(BUILD_MODULES); \
	module list; \
	uv_dir="$${UV_PYTHON_INSTALL_DIR:-$(BUILD_PATH)}"; \
	UV_PYTHON_INSTALL_DIR="$${uv_dir}" uv python install --no-bin $(VERSION); \
	mkdir -p "$(PREFIX)"; \
	cp -pR "$${uv_dir}"/cpython-$(VERSION)-*/* "$(PREFIX)/"
	make post_install
	ls -la "$(PREFIX)"
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

post_install:
	if [[ -d "$(PREFIX)/share/man/man1" ]] && [[ ! -e "$(PREFIX)/share/man/man1/python.1" ]]; then \
	    ln -s python3.1 "$(PREFIX)/share/man/man1/python.1"; \
	fi
	find "$(PREFIX)/lib" -name "rot_13.py" -exec chmod a-x {} +
	make --quiet write_protect_install

available-version:
	@module try-load $(BUILD_MODULES) > /dev/null 2>&1; \
	uv python list --all-versions 2> /dev/null | grep -oP 'cpython-\K3\.14\.[0-9]+(?=-linux)' | head -n 1
