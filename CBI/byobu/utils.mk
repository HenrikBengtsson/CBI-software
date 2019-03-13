SHELL=bash

ifndef NAME
  $(error ERROR: Environment variable 'NAME' is not set)
endif

ifndef VERSION
  $(error ERROR: Environment variable 'VERSION' is not set)
endif

TARBALL=$(NAME)_$(VERSION)$(BUILD_SUFFIX).tar.gz

ifndef BUILD_HOME
  ifndef TMPDIR
    $(error ERROR: Environment variable 'TMPDIR' is not set)
  endif
  BUILD_HOME=$(TMPDIR)
endif

ifndef BUILD_NAME
  BUILD_NAME=$(NAME)-$(VERSION)$(BUILD_SUFFIX)
endif

ifndef BUILD_PATH
  BUILD_PATH=$(BUILD_HOME)/$(BUILD_NAME)
endif

ifndef SOFTWARE_HOME
  $(error ERROR: Environment variable 'SOFTWARE_HOME' is not set)
endif

ifndef PREFIX
  PREFIX=$(SOFTWARE_HOME)/$(NAME)-$(VERSION)
endif



ifndef MODULE_HOME
  $(error ERROR: Environment variable 'MODULE_HOME' is not set)
endif

ifndef FULLNAME
  FULLNAME=$(basename $(PREFIX))
endif

ifndef MODULE_NAME
  MODULE_NAME=$(NAME)
endif

MODULE_NAME_VERSION=$(MODULE_NAME)/$(VERSION)
