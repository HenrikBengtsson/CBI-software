SHELL:=bash

i/%:
	cd "$(@F)"; make all

m/%:
	cd "$(@F)"; make module

pkgs: PACKAGES
	@cat PACKAGES | grep -vE "^#" | sort -u

all:
	pkgs=($$(cat PACKAGES | grep -vE "^#" | sort -u)); \
	for ii in $${!pkgs[@]}; do \
	  pkg=$${pkgs[$$ii]}; \
	  printf "%02d. %s ... " "$${ii}" "$${pkg}"; \
	  if [[ -f "$${pkg}/.done" ]]; then \
	    echo "already done"; \
	    continue; \
	  fi; \
          echo; \
	  (cd "$${pkg}"; $(MAKE) all; touch ".done"); \
	done;

unclean:
	for pkg in *; do touch "$${pkg}/.done" 2> /dev/null; done

clean:
	rm -- */.done

PACKAGES: FORCE
	find . -type f -name "config.mk" -exec dirname {} + | sed -E 's/.\///' > "$@"

changelog-urls:
	grep -F "(changelog)" -- */module.lua.tmpl | sed 's/(changelog).*//' | sed -E 's|^(.+)/module.lua.tmpl:.*, |\1\t|'

available-version:
@for ff in */config.mk; do dd=$$(dirname "$$ff"); grep -qE "^available-version:" "$$dd/Makefile" && (cd "$$dd"; v=$$(make --quiet version); av=$$(make --quiet available-version); [[ $$av == $$v ]] && [[ -z "$(FULL)" ]] || echo "$$dd: $$v -> $$av"; ); done

FORCE:
