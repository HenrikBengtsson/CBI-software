SHELL=bash

modulerc: $(MODULE_HOME)/.modulerc.lua

$(MODULE_HOME)/.modulerc.lua: .modulerc.lua.sh FORCE
	echo "Updating: $@"
	./"$<" > "$@".tmp
	chmod ugo-w "$@".tmp
	mv -f "$@".tmp "$@"

install/%:
	@cd "$(@F)"; $(MAKE) all

module/%:
	@cd "$(@F)"; $(MAKE) module

check/%:
	@cd "$(@F)"; $(MAKE) check

check-libs/ALL:
	@mapfile -t modules < <(find "$${MODULE_ROOT_CBI}" -maxdepth 1 -type d -exec basename {} \; | sort -u | grep -v -E "(miniconda3-py)"); \
	echo "Scanning $${#modules[@]} modules:"; \
	for kk in $$(seq "$${#modules[@]}"); do \
	    mm="$${modules[$$((kk - 1))]}"; \
	    echo "$${kk}/$${#modules[@]}: $${mm}"; \
            [[ -d "$${mm}" ]] && make --quiet "$(@D)/$${mm}"; \
	done

check-rpath/ALL:
	@mapfile -t modules < <(find "$${MODULE_ROOT_CBI}" -maxdepth 1 -type d -exec basename {} \; | sort -u | grep -v -E "(miniconda3-py)"); \
	echo "Scanning $${#modules[@]} modules:"; \
	for kk in $$(seq "$${#modules[@]}"); do \
	    mm="$${modules[$$((kk - 1))]}"; \
	    echo "$${kk}/$${#modules[@]}: $${mm}"; \
            [[ -d "$${mm}" ]] && make --quiet "$(@D)/$${mm}"; \
	done

check-absolute-paths/ALL:
	@mapfile -t modules < <(find "$${MODULE_ROOT_CBI}" -maxdepth 1 -type d -exec basename {} \; | sort -u | grep -v -E "(miniconda3-py)"); \
	echo "Scanning $${#modules[@]} modules:"; \
	for kk in $$(seq "$${#modules[@]}"); do \
	    mm="$${modules[$$((kk - 1))]}"; \
	    echo "$${kk}/$${#modules[@]}: $${mm}"; \
            [[ -d "$${mm}" ]] && make --quiet "$(@D)/$${mm}"; \
	done

check-libs/%:
	@cd "$(@F)"; $(MAKE) $(@D)

check-rpath/%:
	@cd "$(@F)"; $(MAKE) $(@D)

check-absolute-paths/%:
	@cd "$(@F)"; $(MAKE) $(@D)

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

check-results/%: FORCE
	@ \
	if [[ -f "$(@).out"           ]]; then echo "already success";     exit 0; fi; \
	if [[ -f "$(@).fail"          ]]; then echo "already failed";      exit 0; fi; \
	if [[ -f "$(@).skip"          ]]; then echo "marked for skipping"; exit 0; fi; \
	if [[ -f "$(@).not-installed" ]]; then echo "not installed";       exit 0; fi; \
	mkdir -p "$(@D)"; \
	pkg=$(@F); \
	pkg=$${pkg//.out}; \
	if module -r spider "^$${pkg}$$" 2> /dev/null; then \
	    cd "$${pkg}"; \
	    $(MAKE) check 2> /dev/null > ../$(@).tmp && mv ../$(@).tmp ../$(@).out || mv ../$(@).tmp ../$(@).fail; \
	    cd ..; \
	else \
	    touch "$(@).not-installed"; \
	    echo "not installed"; \
	fi; \
	if [[ -f "$(@).out"  ]]; then echo "success";     exit 0; fi; \
	if [[ -f "$(@).fail" ]]; then echo "failed";      exit 0; fi;

check-results/PACKAGES: PACKAGES
	@ \
	pkgs=($$(cat "$<" | grep -vE "^#" | sort -u)); \
	ok=0; half=0; fail=0; skip=0; \
	for ii in $${!pkgs[@]}; do \
	  pkg=$${pkgs[$$ii]}; \
	  printf "%03d/%03d. " "$$((ii+1))" "$${#pkgs[@]}"; \
	  $(MAKE) --no-print-directory $(@D)/$${pkg} > /dev/null; \
	  if [[ -f "$(@D)/$${pkg}.out"  ]]; then \
              if grep -q -F "missing tests/ folder" "$(@D)/$${pkg}.out"; then \
	         printf "[HALF]"; \
	         half=$$((half+1)); \
	      else \
	         printf "[ OK ]"; \
	         ok=$$((ok+1)); \
	      fi; \
	  fi; \
	  if [[ -f "$(@D)/$${pkg}.fail" ]]; then printf "[FAIL]"; fail=$$((fail+1)); fi; \
	  if [[ -f "$(@D)/$${pkg}.skip" ]]; then printf "[SKIP]"; skip=$$((skip+1)); fi; \
	  echo " $${pkg}"; \
	done; \
	printf "\nRESULTS: %d SUCCESS, %d INCOMPLETE, %d FAILED, %d SKIPPED\n" "$${ok}" "$${half}" "$${fail}" "$${skip}"; \

pkgs: PACKAGES
	@cat PACKAGES | grep -vE "^#" | sort -u

unclean:
	for pkg in *; do touch "$${pkg}/.done" 2> /dev/null; done

clean:
	rm -- */.done

PACKAGES:
	@echo "## Last updated: $$(date --rfc-3339=second)" > "$(@).tmp"; \
	pkgs=($$(find . -type f -name "config.mk" -exec dirname {} + | grep -vF wip | sed -E 's/.\///')); \
	echo "Number of installable packages: $${#pkgs[@]}"; \
	count=0; \
	for ii in $${!pkgs[@]}; do \
	    printf "%03d/%03d. " "$$((ii+1))" "$${#pkgs[@]}"; \
	    if module -r spider "^$${pkgs[ii]}$$" 2> /dev/null; then \
	        echo "$${pkgs[ii]}" >> "$(@).tmp"; \
	        printf "[x]"; \
	        count=$$((count + 1)); \
	    else \
	        printf "[ ]"; \
	    fi; \
	    echo " $${pkgs[ii]}"; \
	done; \
	mv "$(@).tmp" "$(@)"; \
	printf "%d out of %d modules available\n" "$${count}" "$${#pkgs[@]}"

changelog-urls:
	grep -F "(changelog)" -- */module.lua.tmpl | sed 's/(changelog).*//' | sed -E 's|^(.+)/module.lua.tmpl:.*, |\1\t|'

available-version:
	@echo "Check for out-of-date config.mk files:"
	@for ff in c*/config.mk; do dd=$$(dirname "$$ff"); grep -qE "^available-version:" "$$dd/Makefile" && printf "[....] %s " "$$dd"; (cd "$$dd"; v=$$(make --quiet version 2> /dev/null | tr $$'\r' $$'\n'); printf "%s" "$$v"; av=$$(timeout 5s make --quiet available-version 2> /dev/null | tr $$'\r' $$'\n'); if [[ -z $$av ]]; then printf "\r[ ?? ] %s %s\n" "$$dd" "$$v"; elif [[ $$av == $$v ]] && [[ -z "$(FULL)" ]]; then printf "\r[ OK ] %s %s\n" "$$dd" "$$v"; elif [[ $$av.0 == $$v ]] && [[ -z "$(FULL)" ]]; then printf "\r[ OK ] %s %s\n" "$$dd" "$$v"; else printf "\r[NOTE] %s %s -> %s\n" "$$dd" "$$v" "$$av"; fi); done

FORCE:
