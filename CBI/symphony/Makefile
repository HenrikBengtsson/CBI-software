include config.mk
include ../utils.mk

INSTALL_TARGET_FILE=lib/pkgconfig/osi-sym.pc
INSTALL_TARGET=$(PREFIX)/$(INSTALL_TARGET_FILE)
include ../utils.mk


GITHUB_REPO=https://github.com/coin-or/SYMPHONY
DOWNLOAD_URL=$(GITHUB_REPO)/releases/download/$(NAME)_$(VERSION_X_Y)

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------
$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_PATH); \
	cd $(BUILD_PATH); \
	curl -L -O "https://raw.githubusercontent.com/coin-or/coinbrew/master/coinbrew"; \
	chmod u+x coinbrew; \
	./coinbrew fetch SYMPHONY@$(VERSION)

## WORKAROUND: We need to build with '--tests=main', because the default
## '--tests=all' triggers error on when "Running Osi unit test", at least
## for SYMPHONY 5.7.3 with Osi 0.108.11.
$(INSTALL_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	./coinbrew build SYMPHONY --prefix="$(PREFIX)" --tests=main --verbosity=1

available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//' | sed -E 's/^hdf5_//'
