#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

ticketid="$1"

echo "[${ticketid}](https://wotc.atlassian.net/browse/${ticketid})"
