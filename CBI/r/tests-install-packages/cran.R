message(sprintf("Start time: %s", Sys.time()))

options(Ncpus = parallelly::availableCores())
message(sprintf("Number of parallel installs: %d", getOption("Ncpus")))

db <- utils::available.packages()
pkgs <- unclass(db[, "Package"])
message(sprintf("Number of available packages: %d", length(pkgs)))

db <- utils::installed.packages()
skip <- unclass(db[, "Package"])
message(sprintf("Number of installed packages: %d", length(skip)))

pkgs <- setdiff(pkgs, skip)
message(sprintf("Number of packages to install: %d", length(pkgs)))

chunk_size <- 1L
nchunks <- floor(length(pkgs) / chunk_size)
sets <- parallel::splitIndices(length(pkgs), nchunks)
message(sprintf("Number of install chunks: %d (%d packages per chunk)", length(sets), chunk_size))

for (kk in seq_along(sets)) {
  set <- sets[[kk]]
  pkgs_kk <- pkgs[set]

  message(sprintf("Current time: %s", Sys.time()))

  ## Skip already installed packages
  db <- utils::installed.packages()
  skip <- unclass(db[, "Package"])
  message(sprintf("Number of installed packages: %d", length(skip)))
  
  pkgs_kk <- setdiff(pkgs_kk, skip)
  message(sprintf("Packages to install: [n=%d] %s", length(pkgs_kk), paste(unique(c(head(pkgs_kk, 6), "...", tail(pkgs_kk, 3))), collapse = ", ")))

  t0 <- Sys.time()
  utils::install.packages(pkgs_kk)
  dt <- Sys.time() - t0

  message(sprintf("Processing time: %s", dt))
}

message(sprintf("Finish time: %s", Sys.time()))
