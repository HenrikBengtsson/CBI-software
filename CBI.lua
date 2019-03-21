help([[
The Computational Biology and Informatics (CBI) Software Repository
]])
whatis("Title: The Computational Biology and Informatics (CBI) Software Repository")
whatis("Description: Repository of software shared by the Computational Biology and Informatics (http://cbi.ucsf.edu) at the UCSF Helen Diller Family Comprehensive Cancer Center.")
whatis("URL: http://cbi.ucsf.edu/")
whatis("BugReports: Please contact the maintainer of this repository")
whatis("Maintainer: Henrik Bengtsson, Computational Biology and Informatics (http://cbi.ucsf.edu)")
whatis("Keywords: UCSF, CBI, repository")

require "io"
function isdir(fn)
    return (posix.stat(fn, "type") == 'directory')
end

-- Wynton or TIPCC?
local cbi_software_home="UNKNOWN"
if isdir("/wynton/home/cbi/hb") then
   cbi_software_home = "/wynton/home/cbi/hb"
elseif isdir("/home/shared/cbc/software_cbc") then
   cbi_software_home = "/home/shared/cbc/software_cbc"
else
   error("Unknown file system")
end

local apps_root = pathJoin(cbi_software_home, "shared/apps")
setenv("SOFTWARE_ROOT_CBI", pathJoin(apps_root, "manual"))

local shared_modulepath_root=pathJoin(apps_root, "modulefiles")
local name = myModuleName()
local modulepath = pathJoin(shared_modulepath_root, name)
setenv("MODULE_ROOT_CBI", modulepath)
prepend_path("MODULEPATH", modulepath)

-- Legacy (the UCSF CBC group was renamed to CBI in early 2018)
setenv("CBI_APPS_ROOT", apps_root)
setenv("CBC_APPS_ROOT", apps_root)
setenv("SOFTWARE_ROOT_CBC", pathJoin(apps_root, "manual"))
setenv("MODULE_ROOT_CBC", modulepath)
