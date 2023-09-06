#! /usr/bin/env bash

path=${MODULE_HOME:?}

{
echo "-- DO NOT EDIT THIS FILE! IT IS AUTOMATICALLY GENERATED."
echo "-- Last updated: $(date --rfc-3339=seconds)"
echo ""


## Hide too specific R versions
echo "-- Hide R module versions that include GCC version;"
echo "-- it's suffient expose their shorter aliases"
mapfile -t versions < <(find "${MODULE_HOME}/r" -type f -name '*gcc*' -printf '%f\n' | sed -E 's/[.]lua//' | grep -v -E "^[.]")
for version in "${versions[@]}"; do
  printf "hide_version(\"r/%s\")\n" "${version}"
done
}

