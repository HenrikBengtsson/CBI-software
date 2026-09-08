include config.mk
include ../utils.mk

## MATLAB is installed and maintained outside of CBI (by CoreHPC)
MATLAB_ROOT=/mnt/software/ood/MATLAB

available-version:
	@ls -d $(MATLAB_ROOT)/R[0-9][0-9][0-9][0-9][a-z] 2> /dev/null | sed 's!.*/!!' | sort -r | head -1
