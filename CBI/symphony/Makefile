include config.mk
include ../utils.mk

BUILD_TARGET=$(PREFIX)/lib/pkgconfig/osi-sym.pc
INSTALL_TARGET=$(BUILD_TARGET)
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

$(BUILD_TARGET): $(DOWNLOAD_TARGET)
	cd $(BUILD_PATH); \
	./coinbrew build SYMPHONY --prefix="$(PREFIX)" --tests=main --verbosity=1

$(INSTALL_TARGET): $(BUILD_TARGET)


available-version:
	@curl --head --silent $(GITHUB_REPO)/releases/latest | grep -i -E "^location:" | sed -E 's/.*(v|\/)//' | sed -E 's/^hdf5_//'
