urls:
	module purge; module load CBI; \
	modules=$$(module --redirect --terse avail | tail -n +2 | sed '1,/:/!d' | grep -E '/$$' | sed 's/\///'); \
	for module in $$modules; do \
	    bfr=$$(module --redirect show "$$module"); \
	    version=$$(echo "$$bfr" | grep "Version:" | sed -E 's/(^[^:]+:[[:space:]]*|"\)$$)//g'); \
	    urls=$$(echo "$$bfr" | grep "URL:" | sed -E 's/(^[^:]+:[[:space:]]*|"\)$$)//g'); \
	    echo "* $$module/$$version: $$urls"; \
	done

