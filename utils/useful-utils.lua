require "posix"
function isdir(fn)
  return (posix.stat(fn, "type") == "directory")
end

function is_empty(s)
  return((s == nil) or (s == ""))
end

function has_envvar(name)
  return(not is_empty(os.getenv(name)))
end

function on_dev_node()
  -- Assume development node unless Slurm or SGE environment variables are set
  return(not (has_envvar("SLURM_CLUSTER_NAME") or has_envvar("JOB_ID")))
end

has_devtoolset = function(version)
  local path = pathJoin("/opt", "rh", "devtoolset-" .. version)
  return(isdir(path))
end
