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

-- Wynton, C4, or TIPCC?
local cbi_software_home="UNKNOWN"
local cbi_modules_home="UNKNOWN"

if isdir("/wynton/home/cbi/shared/software/CBI") then
   -- Wynton
   cbi_software_home = "/wynton/home/cbi/shared/software/CBI"
   cbi_modules_home  = "/wynton/home/cbi/shared/modulefiles/CBI"
elseif isdir("/home/shared/cbc/software_cbc/shared/apps/manual") then
   -- TIPCC (legacy)
   cbi_software_home = "/home/shared/cbc/software_cbc/shared/apps/manual"
   cbi_modules_home  = "/home/shared/cbc/software_cbc/shared/apps/modulefiles/CBI"
else
   error("Unknown file system")
end

setenv("SOFTWARE_ROOT_CBI", cbi_software_home)
setenv("MODULE_ROOT_CBI", cbi_modules_home)
prepend_path("MODULEPATH", cbi_modules_home)
