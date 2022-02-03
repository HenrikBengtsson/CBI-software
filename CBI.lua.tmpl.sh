#! /usr/bin/env bash
### Usage:
###  CBI.lua.sh
### Output:
###  CBI.lua

## Infer defaults from the underlying file system
if [[ -d "/wynton/home/cbi/shared/software/CBI" ]]; then
   2>&1 echo "File system: Wynton (https://wynton.ucsf.edu/)"
   software_root = "/wynton/home/cbi/shared/software/CBI"
   module_root  = "/wynton/home/cbi/shared/modulefiles/CBI"
elif [[ -d "/software/c4/cbi/software/" ]]; then
   2>&1 echo "File system: C4 (https://www.c4.ucsf.edu/)"
   software_root = "/software/c4/cbi/software"
   module_root  = "/software/c4/cbi/modulefiles"
elif [[ -d "/home/shared/cbc/software_cbc/shared/apps/manual" ]]; then
   2>&1 echo "File system: TIPCC (legacy)"
   software_root = "/home/shared/cbc/software_cbc/shared/apps/manual"
   module_root  = "/home/shared/cbc/software_cbc/shared/apps/modulefiles/CBI"
else
   software_root=
   module_root=
fi

software_root=${SOFTWARE_ROOT_CBI:-${software_root}}
module_root=${MODULE_ROOT_CBI:-${module_root}}

[[ -z ${software_root} ]] && { 2>&1 echo "ERROR: Failed to infer 'SOFTWARE_ROOT_CBI' from the file system. Please set manually"; exit 1; }
[[ -z ${module_root} ]] && { 2>&1 echo "ERROR: Failed to infer 'MODULE_ROOT_CBI' from the file system. Please set manually"; exit 1; }

cat > CBI.lua <<- HEREDOC
help("Module Repository by Computational Biology and Informatics (CBI)")

local name = myModuleName()

whatis("Keywords: UCSF, CBI")
whatis("URL: https://cbi.ucsf.edu/")
whatis("Description: Repository of modules shared by Computational Biology and Informatics (http://cbi.ucsf.edu/). When loading this module, you will get access to a large number of software modules.  When unloading the module, any software modules from this " .. name .. " repository still loaded when you unload this repository module, will remain in your list of loaded modules but will be inactivate (i.e. behave as they never were loaded) until you reload this repository module again.  Example: \`module load " .. name .. "\` and then \`module avail\`.")

pushenv("SOFTWARE_ROOT_CBI", "${software_root}")
pushenv("MODULE_ROOT_CBI", "${module_root}")
prepend_path("MODULEPATH", "${module_root}")
HEREDOC
