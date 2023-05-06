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

module purge
module load CBI r/.4.3.0-gcc10
module load mpi/openmpi3-x86_64
module load CBI hdf5 gdal

Rscript --version

Rscript "cran.R"

## End-of-job summary, if running as a job
[[ -n "$JOB_ID" ]] && qstat -j "$JOB_ID"  # This is useful for debugging and usage purposes,
                                          # e.g. "did my job exceed its memory request?"

printf "[%s] Installing all CRAN packages ... done\n" "$(date --rfc-3339=seconds)"
