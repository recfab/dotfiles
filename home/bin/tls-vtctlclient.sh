#!/bin/bash

# Bash unofficial strict mode, Google it if you you want to know more.
set -euo pipefail
# Below from bash unofficial strict mode, but I prefer not to use it
#IFS=$'\n\t'

vi_path="$HOME/Code/vitess-internal"
client_path="$vi_path/python/tls_vtctlclient"

# check if the python virtual environment exists
if [ ! -d "$client_path/.venv" ]; then
  echo "The python virtual environment $client_path/.venv doesn't exist. Please cd into the $client_path directory, run ./install.sh, and retry execution."
  exit 1
fi

$client_path/.venv/bin/tls-vtctlclient "$@"

# EOF.
