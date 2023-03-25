SHELL=bash

## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## LINUX DISTRIBUTION
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ifndef LINUX_NAME
  LINUX_NAME=$(shell test -f /etc/os-release && { source /etc/os-release; echo "$$NAME"; })
endif

ifndef LINUX_VERSION
  ifeq ($(LINUX_NAME),Ubuntu)
      LINUX_VERSION=$(shell test -f /etc/os-release && { source /etc/os-release; echo "$$VERSION_ID"; })
  endif
endif

sysinfo:
	@echo "LINUX_NAME=$(LINUX_NAME)"
	@echo "LINUX_VERSION=$(LINUX_VERSION)"


