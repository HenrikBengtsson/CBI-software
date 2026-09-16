#!/bin/bash
## The name RMariaDB and RMySQL look for first; 'mariadb_config' derives
## its paths from argv[0], so exec it under its own name
exec "$(dirname "$(readlink -f "$0")")/mariadb_config" "$@"
