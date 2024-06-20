#!/bin/bash
set -euo pipefail

# TODO finish this.
# We sometimes need to verify that the storage class in the keyspaceshard spec
# matches that of the STS.
keyspaceshard_name="$1"
workdir=$(mktemp -d)

hs-kubectl get ks 
