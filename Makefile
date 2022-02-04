SHELL=bash

CBI.lua: repos/CBI.lua

repos/CBI.lua: repos/CBI.lua.tmpl.sh
	$< > "$@".tmp
	luac -p "$@".tmp
	mv "$@".tmp "$@"

install: repos/CBI.lua
	@module purge; \
	unset MODULE_ROOT_CBI; \
	export MODULEPATH=".:$${MODULEPATH}"; \
	module load CBI; \
	echo "MODULE_ROOT_CBI=$${MODULE_ROOT_CBI}"; \
	[[ -n $${MODULE_ROOT_CBI} ]] || { >&2 echo "MODULE_ROOT_CBI not set"; exit 1; }; \
	[[ -d "$${MODULE_ROOT_CBI}" ]] || { >&2 echo "No such folder: $${MODULE_ROOT_CBI}"; exit 1; }; \
	path=$$(dirname "$${MODULE_ROOT_CBI}"); \
	mkdir -p "$${path}/repos"; \
	cp "$<" "$${path}/repos"; \
	echo "Installed: $${path}/$<"; \
	ls -l "$${path}/$<"; \
	cat "$${path}/$<"


check: shellcheck check.lua check.lua.tmpl

shellcheck:
	echo "ShellCheck $$(shellcheck --version | grep version:)"
	shellcheck repos/CBI.lua.tmpl.sh

check.lua:
	echo "luac $$(luac -v)"
	for f in $$(find . -type f -name "*.lua" -print); do \
	    echo "Checking: $${f}"; \
	    luac -p "$${f}" || { >&2 echo "ERROR: Syntax error in $${f}"; exit 1; }; \
	done

check.lua.tmpl:
	echo "luac $$(luac -v)"
	for f in $$(find . -type f -name "*.lua.tmpl" -print); do \
	    echo "Checking: $${f}"; \
	    luac -p "$${f}" || { >&2 echo "ERROR: Syntax error in $${f}"; exit 1; }; \
	done

urls:
	module purge; module load CBI; \
	modules=$$(module --redirect --terse avail | tail -n +2 | sed '1,/:/!d' | grep -E '/$$' | sed 's/\///'); \
	for module in $$modules; do \
	    bfr=$$(module --redirect show "$$module"); \
	    version=$$(echo "$$bfr" | grep "Version:" | sed -E 's/(^[^:]+:[[:space:]]*|"\)$$)//g'); \
	    urls=$$(echo "$$bfr" | grep "URL:" | sed -E 's/(^[^:]+:[[:space:]]*|"\)$$)//g'); \
	    echo "* $$module/$$version: $$urls"; \
	done
