SHELL:=bash

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

FORCE:

