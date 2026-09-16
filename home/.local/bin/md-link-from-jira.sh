#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

ticketid="$1"

echo "[${ticketid}](https://clinical-research-io.atlassian.net/browse/${ticketid})"
