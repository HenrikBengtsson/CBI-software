help("openjdk: Open Java Development Kit")

local name = myModuleName()
local version = myModuleVersion()
whatis("Version: " .. version)
whatis("Keywords: programming, java")
whatis("URL: https://openjdk.java.net/, https://openjdk.java.net/projects/jdk/ (changelog), https://github.com/openjdk/jdk (source code)")
whatis([[
Description: OpenJDK is a free and open-source implementation of the Java Platform, Standard Edition. It is the result of an effort Sun Microsystems began in 2006.
Examples: `java -version` and `javac -version` (SDK only).
Note: This module loads the Software Development Kit (SDK) version, if available, otherwise the Run-Time Environment (JRE).
]])

local root = "/usr/lib/jvm"

-- Use SDK, if available, otherwise JRE
local home = pathJoin(root, "java" .. "-" .. version)
if not isDir(home) then -- isDir() supports symlinked folders
    home = pathJoin(root, "jre" .. "-" .. version)
end

setenv("JAVA_HOME", home)
prepend_path("PATH", pathJoin(home, "bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(home, "lib"))
prepend_path("CPATH", pathJoin(home, "include"))
