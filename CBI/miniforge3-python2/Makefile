include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

## Create a standalone Python 2.7 environment using Conda from the
## CBI 'miniforge3' module, i.e.
##
##   conda create --prefix "$(PREFIX)" python=2.7 --yes
##
$(INSTALL_TARGET):
	module purge; \
	module load CBI miniforge3; \
	conda create --yes --prefix "$(PREFIX)" "python=$(PYTHON_VERSION)"
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

post_install:
	make --quiet write_protect_install
