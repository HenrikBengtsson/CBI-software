include config.mk

TAIL:=$(VERSION)
RSTUDIO_VERSION_MAJOR:=$(shell echo "$(TAIL)" | sed -E 's/[^[:digit:]][^.]*//g')
TAIL:=$(shell echo "$(TAIL)" | sed "s/$(RSTUDIO_VERSION_MAJOR)[.]//")
RSTUDIO_VERSION_MINOR:=$(shell echo "$(TAIL)" | sed -E 's/[^[:digit:]][^.]*//g')
TAIL:=$(shell echo "$(TAIL)" | sed "s/$(RSTUDIO_VERSION_MINOR)[.]//")
RSTUDIO_VERSION_PATCH:=$(shell echo "$(TAIL)" | sed -E 's/[^[:digit:]][^.]*//g')
TAIL:=$(shell echo "$(TAIL)" | sed "s/$(RSTUDIO_VERSION_PATCH)//")
RSTUDIO_VERSION_SUFFIX:=$(TAIL)
VERSION_MINUS:=$(RSTUDIO_VERSION_MAJOR).$(RSTUDIO_VERSION_MINOR).$(RSTUDIO_VERSION_PATCH)$(shell echo "$(RSTUDIO_VERSION_SUFFIX)" | tr '+' '-')
VERSION_PLUS:=$(RSTUDIO_VERSION_MAJOR).$(RSTUDIO_VERSION_MINOR).$(RSTUDIO_VERSION_PATCH)$(shell echo "$(RSTUDIO_VERSION_SUFFIX)" | tr '-' '+')
VERSION:=$(VERSION_MINUS)

include ../utils.mk

URL_ROOT=https://download1.rstudio.org/electron

## Centos 7.9
ARCH=x86_64-fedora
URL_PATH=centos7/x86_64

ifeq ($(LINUX_NAME),Ubuntu)
  ARCH=amd64-debian
  ifeq ($(LINUX_VERSION),20.04)
    URL_PATH=bionic/amd64
  endif
  ifeq ($(LINUX_VERSION),22.04)
    URL_PATH=jammy/amd64
  endif
endif

URL=$(URL_ROOT)/$(URL_PATH)/$(TARBALL)

VERSION_URL:=$(shell echo "$(VERSION)" | sed 's/+/%2B/g')
TARBALL=$(NAME)-$(VERSION_URL)-${ARCH}.tar.gz


debug3:
	@echo "ARCH=$(ARCH)"
	@echo "VERSION=$(VERSION)"
	@echo "RSTUDIO_VERSION_MAJOR=$(RSTUDIO_VERSION_MAJOR)"
	@echo "RSTUDIO_VERSION_MINOR=$(RSTUDIO_VERSION_MINOR)"
	@echo "RSTUDIO_VERSION_PATCH=$(RSTUDIO_VERSION_PATCH)"
	@echo "RSTUDIO_VERSION_SUFFIX=$(RSTUDIO_VERSION_SUFFIX)"
	@echo "VERSION_MINUS=$(VERSION_MINUS)"
	@echo "VERSION_PLUS=$(VERSION_PLUS)"
	@echo "VERSION=$(VERSION)"

## ----------------------------------------------------------
## SOFTWARE
## ----------------------------------------------------------

$(DOWNLOAD_TARGET):
	mkdir -p $(BUILD_HOME); \
	cd $(BUILD_HOME); \
	curl -L -O "$(URL)"; \
	tar zxf "$(TARBALL)"; \
	mv "$(NAME)-$(VERSION_PLUS)" "$(NAME)-$(VERSION)"


$(CONFIG_TARGET): $(DOWNLOAD_TARGET)
	@cd "$(BUILD_PATH)"; \
	find . -type f -name "*.so" -exec ldd {} 2> /dev/null ';' | grep -F "not found" > "$(CONFIG_TARGET).tmp" || true
	if grep -q -F "not found" "$(CONFIG_TARGET).tmp"; then \
	   { echo "ERROR: Missing system libraries:"; grep -F "not found" "$(CONFIG_TARGET).tmp" | uniq; } 1>&2; \
	   exit 1; \
	fi
	mv "$(CONFIG_TARGET).tmp" "$(CONFIG_TARGET)"

$(INSTALL_TARGET): $(CONFIG_TARGET)
	mkdir -p $(PREFIX)
	cp -R $(BUILD_PATH) $(PREFIX)/..
	make post_install
	ls -la $(PREFIX)
	@echo "SOFTWARE INSTALLED TO: $(PREFIX)"

available-version:
#	@curl --silent https://docs.posit.co/ide/news/ | pandoc --from=html --to=plain | grep -E "RStudio [[:digit:]]+[.][[:digit:]]+[.][[:digit:]]+\b" | sed -E 's/^(-[[:space:]]+|)RStudio //' | uniq | head -1
	@curl --silent https://github.com/rstudio/rstudio/tags | pandoc --from=html --to=plain | grep -E "^v[[:digit:]]+[.][[:digit:]]+[.][[:digit:]]+" | sed -E 's/^v//' | head -1 | sed 's/+/-/'

FORCE:
