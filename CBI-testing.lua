help([[
The Computational Biology and Informatics (CBI) Software Repository - TESTING ONLY!
]])

local name = myModuleName()
whatis("Title: The Computational Biology and Informatics (CBI) Software Repository - TESTING ONLY!")
whatis("Description: This repository provides prototypical environment modules that can change at any time. They will live in this CBI-testing repository until they have proven to work and be stable - only then they will be considered for the main CBI repository.  WARNING: Use at your own risk.")
whatis("URL: http://cbi.ucsf.edu/")
whatis("BugReports: Please contact the maintainer of this repository")
whatis("Maintainer: Henrik Bengtsson, Computational Biology and Informatics (http://cbi.ucsf.edu)")
whatis("Keywords: UCSF, CBI, repository, testing")

local root = os.getenv("SOFTWARE_ROOT_CBI")
root = pathJoin(root, "..")

local software_home = pathJoin(root, "software", name)
local modules_home = pathJoin(root, "modulefiles", name)

setenv("SOFTWARE_ROOT_CBI_TESTING", software_home)
setenv("MODULE_ROOT_CBI_TESTING", modules_home)
prepend_path("MODULEPATH", modules_home)
