SHELL=bash

urls:
	module purge; module load CBI; \
	modules=$$(module --redirect --terse avail | tail -n +2 | sed '1,/:/!d' | grep -E '/$$' | sed 's/\///'); \
	for module in $$modules; do \
	    bfr=$$(module --redirect show "$$module"); \
	    version=$$(echo "$$bfr" | grep "Version:" | sed -E 's/(^[^:]+:[[:space:]]*|"\)$$)//g'); \
	    urls=$$(echo "$$bfr" | grep "URL:" | sed -E 's/(^[^:]+:[[:space:]]*|"\)$$)//g'); \
	    echo "* $$module/$$version: $$urls"; \
	done

CBI.lua: CBI.lua.tmpl.sh
	./$<
	luac -p "$@"

install: CBI.lua
	@module purge; \
	unset MODULE_ROOT_CBI; \
	export MODULEPATH=".:$${MODULEPATH}"; \
	module load CBI; \
	echo "MODULE_ROOT_CBI=$${MODULE_ROOT_CBI}"; \
	[[ -n $${MODULE_ROOT_CBI} ]] || { 2>&1 echo "MODULE_ROOT_CBI not set"; exit 1; }; \
	path=$$(dirname "$${MODULE_ROOT_CBI}")/repos; \
	[[ -d "$${path}" ]] || { 2>&1 echo "No such folder: $${path}"; exit 1; }; \
	cp "$<" "$${path}"; \
	echo "Installed: $${path}/$<"; \
	cat "$${path}/$<"


check: shellcheck check.lua check.lua.tmpl

shellcheck:
	echo "ShellCheck $$(shellcheck --version | grep version:)"
	shellcheck CBI.lua.tmpl.sh

check.lua:
	echo "luac $$(luac -v)"
	for f in $$(find . -type f -name "*.lua" -print); do \
	    echo "Checking: $${f}"; \
	    luac -p "$${f}" || { 2>&1 echo "ERROR: Syntax error in $${f}"; exit 1; }; \
	done

check.lua.tmpl:
	echo "luac $$(luac -v)"
	for f in $$(find . -type f -name "*.lua.tmpl" -print); do \
	    echo "Checking: $${f}"; \
	    luac -p "$${f}" || { 2>&1 echo "ERROR: Syntax error in $${f}"; exit 1; }; \
	done
