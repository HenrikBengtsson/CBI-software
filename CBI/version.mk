SHELL=bash

ifndef VERSION
  $(error ERROR: Environment variable 'VERSION' is not set)
endif

$(eval REMAINDER := $$$(VERSION))
$(eval REMAINDERtmp := $$$(REMAINDER))
$(eval REMAINDER2 := $$$(REMAINDERtmp))
#VERSION_X := $(subst $(REMAINDER),,$(VERSION))
#VERSION_X_Y := $(subst $(REMAINDER2),,$(VERSION))
VERSION_X_Y_Z_ZZ := $(shell echo "$(VERSION)" | sed -E 's/([[:digit:]]+)([.-])([[:digit:]]+)([.-])([[:digit:]]+)([.-])([[:digit:]]+).*/\1\2\3\4\5\6\7/')
VERSION_X_Y_Z := $(shell echo "$(VERSION)" | sed -E 's/[+][[:digit:]]+$$//' | sed -E 's/([[:digit:]]+)([.-])([[:digit:]]+)([.-])([[:digit:]]+).*/\1\2\3\4\5/')
VERSION_X_Y := $(shell echo "$(VERSION_X_Y_Z)" | sed -E 's/[.-][^.-]*$$//')
VERSION_X := $(shell echo "$(VERSION_X_Y)" | sed -E 's/[.-][^.-]*$$//')
VERSION_Y := $(shell echo "$(VERSION_X_Y)" | sed -E 's/^[^.-]*[.-]//')


## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## DEBUG
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
debug_version:
	@echo "VERSION: $(VERSION)"
	@echo "VERSION_X_Y_Z_ZZ: $(VERSION_X_Y_Z_ZZ)"
	@echo "VERSION_X_Y_Z: $(VERSION_X_Y_Z)"
	@echo "VERSION_X_Y: $(VERSION_X_Y)"
	@echo "VERSION_X: $(VERSION_X)"
	@echo "VERSION_Y: $(VERSION_Y)"
