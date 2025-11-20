#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Build the siteapp JS assets
siteapp_dir="$HOME/projects/crio"

pushd "$siteapp_dir/public_html/js/modules"

npm run build

popd


pushd "$siteapp_dir/public_html/js/vite-crio-components"

npm run build

popd