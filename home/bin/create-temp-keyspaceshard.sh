#!/bin/bash
set -euo pipefail

GIT_ROOT=$(git rev-parse --show-toplevel)
VITESS_DEPLOYER_ROOT="$(go env GOPATH)/src/git.hubteam.com/hubspot/vitess-deployer"
USER="${1:-$(whoami)}"

formatted_username=$(echo "$USER" | awk -vOFS='' '{ print toupper(substr($0, 1, 2)),substr($0,3) }')
unixtime=$(date +%s)
export keyspace_name="${formatted_username}Temp${unixtime}"
lower_keyspace_name=$(echo "$keyspace_name" | awk '{ print tolower($0) }')
export keyspaceshard_name="$lower_keyspace_name-0"
export namespace="vt-green"

base_file="$VITESS_DEPLOYER_ROOT/deploy/testkeyspaceshard.yaml"

yq_program='
  .metadata.namespace=env(namespace) |
  .metadata.name=env(keyspaceshard_name) |
  .metadata.labels.belongsto = env(USER) |
  .spec.keyspace=env(keyspace_name)
'

tmpfile=$(mktemp)
outfile="${tmpfile}.yaml"
mv "$tmpfile" "$outfile"

yq "$yq_program" "$base_file" > "$outfile"

hs-kubectl safe-apply -f "$outfile"
