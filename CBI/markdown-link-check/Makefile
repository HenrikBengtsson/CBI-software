include config.mk
include ../utils.mk


## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

## WORKAROUND: It looks like we have to set 'npm_config_cache' to folder
## on the local drive, instead of the default $HOME/.npm/ folder, which
## lives on BeeGFS (on C4 and Wynton).  When using the default, we get
## the following obscure error message from 'npm install':
##
## $ npm install markdownlint-cli
## npm ERR! code EPERM
## npm ERR! syscall link
## npm ERR! path $HOME/.npm/_cacache/tmp/7ec5d890
## npm ERR! dest $HOME/.npm/_cacache/content-v2/sha512/1b/cb/5bc688963c86b8ecbb58c4d3e11d3376e40a93d1c440dd7c8d0400cecd6cff123317d8625d5ccf45c8ed18d00bc34011dda3030ba82eec92612819a5df0f
## npm ERR! errno EPERM
## npm ERR! 
## npm ERR! Your cache folder contains root-owned files, due to a bug in
## npm ERR! previous versions of npm which has since been addressed.
## npm ERR! 
## npm ERR! To permanently fix this problem, please run:
## npm ERR!   sudo chown -R 581:509 "$HOME/.npm"
##
## /HB 2022-10-21
$(INSTALL_TARGET):
	cd $(BUILD_PATH); \
	module purge; \
	npm_config_cache="$$(mktemp -d)" npm install --prefix="$(PREFIX)" markdown-link-check
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
	npm view markdown-link-check version

