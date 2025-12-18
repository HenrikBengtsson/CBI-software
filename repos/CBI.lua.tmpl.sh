#! /usr/bin/env bash
### Usage:
###  CBI.lua.sh
### Output:
###  CBI.lua

## Infer defaults from the underlying file system
if [[ -d "/wynton/home/cbi/shared/software/CBI" ]]; then
   >&2 echo "File system: Wynton (https://wynton.ucsf.edu/)"
   software_root="/wynton/home/cbi/shared/software/CBI"
   module_root="/wynton/home/cbi/shared/modulefiles/CBI"
elif [[ -d "/software/c4/cbi/software/" ]]; then
   >&2 echo "File system: C4 (https://www.c4.ucsf.edu/)"
   software_root="/software/c4/cbi/software"
   module_root="/software/c4/cbi/modulefiles"
elif [[ ${HOSTNAME} == *".corehpc.ucsf.edu" ]]; then
   >&2 echo "File system: CoreHPC (https://it.ucsf.edu/service/corehpc)"
   software_root="$HOME/shared/cbi/software"
   module_root="$HOME/shared/cbi/modulefiles"
elif [[ -d "/home/shared/cbc/software_cbc/shared/apps/manual" ]]; then
   >&2 echo "File system: TIPCC (legacy)"
   software_root="/home/shared/cbc/software_cbc/shared/apps/manual"
   module_root="/home/shared/cbc/software_cbc/shared/apps/modulefiles/CBI"
elif [[ -d "$HOME/shared/software/CBI" ]]; then
   >&2 echo "File system: \$HOME"
   software_root="$HOME/shared/software/CBI"
   module_root="$HOME/shared/modulefiles/CBI"
elif [[ -d "$HOME/software/cbi/" ]]; then
   >&2 echo "File system: \$HOME (legacy)"
   software_root="$HOME/software/cbi/software"
   module_root="$HOME/software/cbi/modulefiles"
else
   software_root=${SOFTWARE_HOME:?}
   module_root=${MODULE_HOME:?}
fi

software_root=${SOFTWARE_ROOT_CBI:-${software_root}}
module_root=${MODULE_ROOT_CBI:-${module_root}}

[[ -z ${software_root} ]] && { >&2 echo "ERROR: Failed to infer 'SOFTWARE_ROOT_CBI' from the file system. Please set manually"; exit 1; }
[[ -z ${module_root} ]] && { >&2 echo "ERROR: Failed to infer 'MODULE_ROOT_CBI' from the file system. Please set manually"; exit 1; }

cat <<- HEREDOC
help("Module Repository by UCSF Computational Biology and Informatics (CBI)")

whatis("Keywords: UCSF, CBI")
whatis("URL: https://cbi.ucsf.edu/")
whatis([[
Description: Repository of modules shared by UCSF Computational Biology and Informatics. When loading this module, you will get access to a large number of software modules.  When unloading the module, any software modules from this CBI software repository still loaded when you unload this repository module, will remain in your list of loaded modules but will be inactivate (i.e. behave as they never were loaded) until you reload this repository module again.
Example: \`module load CBI\` and then \`module avail\`.
Maintainer: Henrik Bengtsson, CBI
]])

-- Use subset of modules on select host types?
local module_root = "${module_root}"
local hostname = os.getenv("HOSTNAME") or "unknown"
if hostname:match("log%d$") then
   -- Login hosts
   module_root = pathJoin(module_root, "_login-host")
elseif hostname:match("dt%d$") then
   -- Data-transfer hosts
   module_root = pathJoin(module_root, "_dt-host")
end

-- Identify Linux distribution and set CBI_LINUX accordingly
-- Examples:
-- CentOS 7.9 -> "centos7"
-- Rocky 8.8 -> "rocky8"
-- Rocky 9.6 -> "rocky9"
-- Ubuntu 22.04.3 -> "ubuntu22_04"
local cbi_linux = os.getenv("CBI_LINUX")
if cbi_linux == nil then
  -- /etc/os-release exists on CentOS, Rocky, Ubuntu (>= 16.04)
  if isFile("/etc/os-release") then
    local bfr = capture("cat /etc/os-release")
    for line in string.gmatch(bfr, "[^\n]+") do
      if (string.sub(line, 1, 13) == 'PRETTY_NAME="') then
        line = string.sub(line, 14, string.len(line))
        -- Examples:
        -- CentOS 7.9: "CentOS Linux 7 (Core)"
        -- Rocky 8.8: "Rocky Linux 8.8 (Green Obsidian)"
        -- Rocky 9.6: "Rocky Linux 9.6 (Blue Onyx)"
        -- Ubuntu 22.04.3: "Ubuntu 22.04.3 LTS"

        -- Drop auxillary strings after the version
        line = line:gsub("[ ]+[^0-9]*$", "")
        -- Examples:
        -- CentOS 7.9: "CentOS Linux 7"
        -- Rocky 8.8: "Rocky Linux 8.8"
        -- Rocky 9.6: "Rocky Linux 9.6"
        -- Ubuntu 22.04.3: "Ubuntu 22.04.3"

        -- Work with lower-case strings
        line = string.lower(line)
        line = line:gsub(" linux ", "") -- for CentOS and Rocky
        -- Examples:
        -- CentOS 7.9: "centos 7"
        -- Rocky 8.8: "rocky 8.8"
        -- Rocky 9.6: "rocky 9.6"
        -- Ubuntu 22.04.3: "ubuntu 22.04.3"

        -- Remove spaces
        line = line:gsub("[ ]+", "")
        -- Examples:
        -- CentOS 7.9: "centos7"
        -- Rocky 8.8: "rocky8.8"
        -- Rocky 9.6: "rocky9.6"
        -- Ubuntu 22.04.3: "ubuntu22.04.3"

        -- Drop the last part of the version
        line = line:gsub("[ .][0-9]+$", "")
        -- Examples:
        -- CentOS 7.9: "centos7"
        -- Rocky 8: "rocky8"
        -- Rocky 9: "rocky9"
        -- Ubuntu 22.04.3: "ubuntu22.04"

        -- Replace periods with underscores
        line = line:gsub("[.]", "_")
        -- Examples:
        -- CentOS 7.9: "centos7"
        -- Rocky 8: "rocky8"
        -- Rocky 9: "rocky9"
        -- Ubuntu 22.04.3: "ubuntu22_04"

        cbi_linux = line
        pushenv("CBI_LINUX", cbi_linux)
        break
      end
    end
  else
    cbi_linux = "unknown"
    pushenv("CBI_LINUX", cbi_linux)
  end
end

if cbi_linux ~= "unknown" then
  prepend_path("MODULEPATH", pathJoin(module_root, "_" .. cbi_linux))
end
prepend_path("MODULEPATH", module_root)

pushenv("SOFTWARE_ROOT_CBI", "${software_root}")
pushenv("MODULE_ROOT_CBI", module_root)
HEREDOC
