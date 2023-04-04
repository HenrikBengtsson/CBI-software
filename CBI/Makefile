SHELL=bash

install/%:
	cd "$(@F)"; $(MAKE) all

module/%:
	cd "$(@F)"; $(MAKE) module

check/%:
	cd "$(@F)"; $(MAKE) check

%/PACKAGES: PACKAGES
	@cmd=$(@D); \
	pkgs=($$(cat "$<" | grep -vE "^#" | sort -u)); \
	for ii in $${!pkgs[@]}; do \
	  pkg=$${pkgs[$$ii]}; \
	  printf "%03d/%03d. make %s/%s.out ... " "$$((ii+1))" "$${#pkgs[@]}" "$${pkg}" "$${cmd}"; \
	  if [[ -f "$${pkg}/$${cmd}.out" ]]; then \
	    echo "already done"; \
	    continue; \
	  elif [[ -f "$${pkg}/$${cmd}.out.fail" ]]; then \
	    echo "already failed"; \
	    continue; \
	  fi; \
          echo; \
	  $(MAKE) --no-print-directory $${pkg}/$${cmd}; \
	done;

all: install/PACKAGES

check-results/%.out: FORCE
	@ \
	if [[ -f "$(@)"      ]]; then echo "already success";     exit 0; fi; \
	if [[ -f "$(@).fail" ]]; then echo "already failed";      exit 0; fi; \
	if [[ -f "$(@).skip" ]]; then echo "marked for skipping"; exit 0; fi; \
	mkdir -p "$(@D)"; \
	pkg=$(@F); \
	pkg=$${pkg//.out}; \
	cd "$${pkg}"; \
	$(MAKE) check 2> /dev/null > ../$(@).tmp && mv ../$(@).tmp ../$(@) || mv ../$(@).tmp ../$(@).fail; \
	echo "success"

check-results/PACKAGES: PACKAGES
	@ \
	pkgs=($$(cat "$<" | grep -vE "^#" | sort -u)); \
	for ii in $${!pkgs[@]}; do \
	  pkg=$${pkgs[$$ii]}; \
	  printf "%03d/%03d. make %s/%s.out ... " "$$((ii+1))" "$${#pkgs[@]}" "$(@D)" "$${pkg}"; \
	  $(MAKE) --no-print-directory $(@D)/$${pkg}.out; \
	done;

pkgs: PACKAGES
	@cat PACKAGES | grep -vE "^#" | sort -u

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
