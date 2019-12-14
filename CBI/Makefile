PACKAGES_CMD:="

debug:
	@pkgs=$$(cat PACKAGES | grep -vE "^#" | sort -u); \
	echo pkgs="$${pkgs}";

all:
	pkgs=($$(cat PACKAGES | grep -vE "^#" | sort -u)); \
	for ii in $${!pkgs[@]}; do \
	  pkg=$${pkgs[$$ii]}; \
	  printf "%02d. %s\n" "$${ii}" "$${pkg}"; \
	  (cd "$${pkg}"; $(MAKE) all;); \
	done;
