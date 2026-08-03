#! /bin/bash
set -euo pipefail
IFS=$'\n\t'

this_dir=$(realpath "$(dirname "$0")")
echo "Directory of setup script: $this_dir"

stow --target="$HOME" home

# git config
# echo "Configuring git"
# git config --global init.defaultBranch main

# git config --global diff.tool bc
# git config --global difftool.bc.trustExitCode true

# git config --global merge.tool bc
# git config --global mergetool.bc.trustExitCode true
# git config --global mergetool.keepBackup false

# git config --global core.autocrlf input
# git config --global core.editor 'code --wait'
# git config --global core.pager 'diff-so-fancy | less -RFX'
# git config --global core.whitespace 'blank-at-eol,tab-in-indent'

# git config --global status.submoduleSummary true
# git config --global submodule.recurse true

# git config --global push.followTags true
# git config --global pull.rebase false
