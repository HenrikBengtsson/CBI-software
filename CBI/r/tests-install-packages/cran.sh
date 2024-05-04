#! /usr/bin/env bash
#$ -S /bin/bash      # run job as a Bash shell [IMPORTANT]
#$ -N install-cran
#$ -cwd              # run job in the current working directory
#$ -j y              # STDERR and STDOUT should be joined
#$ -r y              # if job crashes, it should be restarted
#$ -m bea            # send email updates
#$ -l h_rt=72:00:00  # 3 days
#$ -l mem_free=64G
#$ -l scratch=50G
#$ -pe smp 64

printf "[%s] Installing all CRAN packages ...\n" "$(date --rfc-3339=seconds)"
printf "Hostname: %s\n" "$(hostname)"

export MODULEPATH=/c4/home/henrik/modulefiles:/software/c4/cbi/modulefiles:/software/c4/modulefiles/repos:/etc/modulefiles:/usr/share/modulefiles:/usr/share/modulefiles/Linux:/usr/share/modulefiles/Core:/usr/share/lmod/lmod/modulefiles/Core

module purge
module load CBI r/.4.3.0-gcc10
module load CBI cmake
module try-load mpi/openmpi-x86_64
module try-load mpi/openmpi3-x86_64
module load CBI hdf5 gdal
module load CBI geos
module load CBI gsl
module load CBI jags
module load CBI jq
module load CBI r-siteconfig  ## install from CRAN & Bioconductor repositories on the file system

echo "Loaded modules:"
module list

echo "R version:"
Rscript --version

echo "R settings:"
Rscript -e 'cat(sprintf("R_LIBS_USER=%s\n", Sys.getenv("R_LIBS_USER")))' -e 'repos <- getOption("repos"); cat(sprintf("repos:\n%s\n", paste(sprintf(" %s=%s", names(repos), repos), collapse = "\n")))'

xvfb-run Rscript "cran.R"

## End-of-job summary, if running as a job
[[ -n "$JOB_ID" ]] && qstat -j "$JOB_ID"  # This is useful for debugging and usage purposes,
                                          # e.g. "did my job exceed its memory request?"

printf "[%s] Installing all CRAN packages ... done\n" "$(date --rfc-3339=seconds)"
