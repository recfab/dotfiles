#! /bin/bash
set -euo pipefail
IFS=$'\n\t'

this_dir=$(realpath "$(dirname "$0")")
echo "Directory of setup script: $this_dir"

softlink() {
  target="$1"

  if [[ -e "$HOME/$target" ]]; then
    echo "Backing up old version of $target"
    mv "$HOME/$target" "$HOME/$target.bak"
  fi

  echo "Linking $target"
  ln -sf "$this_dir/home/$target" "$HOME/$target"
}

softlink_bin() {
  target="$1"

  if [[ -e "$HOME/bin/$target" ]]; then
    echo "Backing up old version of $target"
    mv "$HOME/bin/$target" "$HOME/bin/$target.bak"
  fi

  echo "Linking $target"
  ln -sf "$this_dir/home/bin/${target}.sh" "$HOME/bin/$target"
}

mkdir -p "$HOME/bin"

softlink '.zshrc'
# softlink '.gitconfig'
softlink '.p10k.zsh'
softlink '.fzf.zsh'
softlink 'com.googlecode.iterm2.plist'

# softlink_bin 'update-eks-kubeconfigs'
# softlink_bin 'create-temp-keyspaceshard'
softlink_bin 'md-link-from-jira'

# git config
echo "Configuring git"
git config --global diff.tool bc
git config --global difftool.bc.trustExitCode true

git config --global merge.tool bc
git config --global mergetool.bc.trustExitCode true
git config --global mergetool.keepBackup false

git config --global core.autocrlf input
git config --global core.editor 'code --wait'
git config --global core.pager 'diff-so-fancy | less -RFX'
git config --global core.whitespace 'blank-at-eol,tab-in-indent'

git config --global status.submoduleSummary true
git config --global submodule.recurse true

git config --global push.followTags true
git config --global pull.rebase false
