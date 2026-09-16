#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

kube_config_d="$HOME/.kube/config.d"

account_alias=$(aws iam list-account-aliases | jq '.AccountAliases[0]' -r)
region=$(aws configure get region)

context_alias_prefix="${account_alias}.${region}"

rm -fv "${kube_config_d}/${context_alias_prefix}.*"

clusters=$(aws eks list-clusters | jq '.clusters | .[]' -r)

for cluster in $clusters; do
    context_alias="${context_alias_prefix}.${cluster}"
    kubeconfig="${kube_config_d}/aws.${context_alias}.yaml"

    aws eks update-kubeconfig --name "$cluster" --kubeconfig "$kubeconfig" --alias "$context_alias"
done
