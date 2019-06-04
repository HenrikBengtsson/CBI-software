all: .incl


.incl: .incl/33.lua .incl/34.lua .incl/36.lua

.incl/33.lua: /opt/rh/python33/enable
	mkdir -p .incl/
	echo "-- Don't edit! Created using: " > $@
	echo "-- $(LMOD_DIR)/sh_to_modulefile $<" > $@
	$(LMOD_DIR)/sh_to_modulefile $< >> $@

.incl/%.lua: /opt/rh/rh-python%/enable
	mkdir -p .incl/
	echo "-- Don't edit! Created using: " > $@
	echo "-- $(LMOD_DIR)/sh_to_modulefile $<" > $@
	$(LMOD_DIR)/sh_to_modulefile $< >> $@

clean:
	rm -f s.log
	rm -rf .incl/
