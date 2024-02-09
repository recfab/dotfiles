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
# softlink 'bin/md-link-from-jira.sh'
softlink_bin 'create-temp-keyspaceshard'
