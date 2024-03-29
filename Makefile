SHELL=bash

CBI.lua: repos/CBI.lua

repos/CBI.lua: repos/CBI.lua.tmpl.sh
	echo "MODULE_HOME=$${MODULE_HOME}"; \
	echo "SOFTWARE_HOME=$${SOFTWARE_HOME}"; \
	[[ -n $${MODULE_HOME} ]] || { >&2 echo "ERROR: Environment variable MODULE_HOME is not set"; exit 1; }; \
	[[ -d "$${MODULE_HOME}" ]] || { >&2 echo "ERROR: No such folder: $${MODULE_HOME}"; exit 1; }; \
	[[ -n $${SOFTWARE_HOME} ]] || { >&2 echo "ERROR: Environment variable SOFTWARE_HOME is not set"; exit 1; }; \
	[[ -d "$${SOFTWARE_HOME}" ]] || { >&2 echo "ERROR: No such folder: $${SOFTWARE_HOME}"; exit 1; }; \
	"$<" > "$@.tmp"  ## compile
	luac -p "$@.tmp" ## validate
	mv "$@.tmp" "$@" ## finalize
	cat "$@"

install: repos/CBI.lua
	@module purge; \
	unset MODULE_ROOT_CBI; \
	export MODULEPATH="repos:$${MODULEPATH}"; \
	echo "MODULEPATH=$${MODULEPATH}"; \
	module load CBI; \
	module show CBI; \
	echo "MODULE_ROOT_CBI=$${MODULE_ROOT_CBI}"; \
	[[ -n $${MODULE_ROOT_CBI} ]] || { >&2 echo "INTERNAL ERROR: Environment variable MODULE_ROOT_CBI is not set"; exit 1; }; \
	[[ -d "$${MODULE_ROOT_CBI}" ]] || { >&2 echo "INTERNAL ERROR: No such folder: $${MODULE_ROOT_CBI}"; exit 1; }; \
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
#	(cd CBI/.incl/; shellcheck -x tests/*.bats)

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
