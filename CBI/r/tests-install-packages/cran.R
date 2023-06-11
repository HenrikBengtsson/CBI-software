message(sprintf("Start time: %s", Sys.time()))

if (utils::file_test("-f", ".lock")) stop("There is already another process running")
file.create(".lock")

if (!requireNamespace("parallelly")) install.packages("parallelly")

options(Ncpus = parallelly::availableCores())
message(sprintf("Number of parallel installs: %d", getOption("Ncpus")))

db <- utils::available.packages()
pkgs <- unclass(db[, "Package"])
message(sprintf("Number of available packages: %d", length(pkgs)))

db <- utils::installed.packages()
skip <- unclass(db[, "Package"])
message(sprintf("Number of installed packages: %d", length(skip)))
pkgs <- setdiff(pkgs, skip)

# -------------------------------------------------------------------------------------
# Packages requires dependencies not available on C4/Wynton
# -------------------------------------------------------------------------------------
`%hence%` <- function(lhs, rhs) c(lhs, rhs)

pkgs_excl <- c(
  ## Gets stuck in an endless "tcltk2" loop if X11 is not available, cf. strace -p <PID>
  "biplotbootGUI",
  "cncaGUI",
  
  ## Packages that require CPLEX (https://www.ibm.com/products/ilog-cplex-optimization-studio)
  "Rcplex" %hence% c("ROI.plugin.cplex", "otinference", "CVXR", "designmatch", "relations", "sbw"),  ## configure: error: CPLEX include directory ./include does not exist

  ## Packages that require OpenCL (https://www.khronos.org/opencl/)
  "gpuMagic",
  "OpenCL",

  ## Packages that require JAGS, i.e. 'module load CBI jags'
  # "rjags" %hence% c("pexm"),

  ## Packages requiring 'MeCab' library
  "RcppMeCab", ## Error: package or namespace load failed for ‘RcppMeCab’ in dyn.load(file, DLLpath = DLLpath, ...): ... undefined symbol: mecab_model_new_tagger
  "RmecabKo",  ## nouns.cpp:10:10: fatal error: mecab.h: No such file or directory

  ## Packages that require .NET framework
  "rawrr" %hence% c("MsBackendRawFileReader"), ##  The cross platform, open source .NET framework (mono) is not available. Consider to install 'apt-get install mono-runtime' on Linux

  ## Packages that require the GLPK library
  "Rglpk" %hence% c("cosso", "designmatch", "FRAPO", "LPmerge", "optrefine", "stratbr", "TukeyRegion", "Bergm", "ConcordanceTest", "eatATA", "ffsimulator", "fPortfolio", "gemtc", "hdme", "HyRiM", "ITRSelect", "kantorovich", "lpda", "MCDA", "MSCMT", "MultAlloc", "multinomineq", "natstrat", "npbr", "otinference", "parma", "ROI.models.miplib", "ROI.plugin.glpk", "sdcTable", "strand", "StratifiedSampling", "visaOTR"),
  
  ## Packages that require OCI libraries
  "ROracle" %hence% c("ora"), ## OCI libraries not found

  ## Packages that require OpenBabel (https://openbabel.org/)
  "ChemmineOB" %hence% c("RMassBank"),  ## Requires <openbabel/obutil.h>

  ## Packages requiring 'OpenBUGS' library (https://openbugs.net)
  ## OpenBUGS is a 32-bit library and requires special build tools
  "BRugs" %hence% c("bcrm", "dclone", "miscF", "R2WinBUGS"),
    "dclone" %hence% c("dcmle", "PVAClone", "sharx", "ordinalbayes"),
    "miscF" %hence% c("agRee", "PottsUtils"),

  ## Packages requiring 'Poppler Glib interface' (poppler-glib-devel)
  "Rpoppler",

  # Packages that requires 'QuantLib' library (https://www.quantlib.org/)
  "RQuantLib" %hence% c("bizdays", "rtsdata"),

  ## Packages requiring 'rrdtool-devel' (installed on C4 but not Wynton)
  # "rrd", ## rrdtool-devel (Fedora, CentOS, RHEL)

  ## Packages that require 'SYMPHONY' library
  "Rsymphony" %hence% c("PortfolioOptim", "prioriactions", "ROI.plugin.symphony"),

  ## Packages requiring Tcl version 8.6
  "loon" %hence% c("loon.ggplot", "loon.shiny", "loon.tourr", "rfviz", "zenplots", "diveR"),
  "switchboard", ## error: [tcl] invalid command name "ttk::style"

  # Packages that require special libraries or dependencies
  "cncaGUI",  ## requires 'Tcl/Tk package BWidget'

  ""
)

message(sprintf("Packages excluded: [n=%d] %s", length(pkgs_excl), paste(unique(c(head(pkgs_excl, 6), "...", tail(pkgs_excl, 3))), collapse = ", ")))

message(sprintf("Number of packages to install: %d", length(pkgs)))

chunk_size <- 50L
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

file.remove(".lock")

message(sprintf("Finish time: %s", Sys.time()))
