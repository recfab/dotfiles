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

softlink '.zshrc'
softlink '.gitconfig'
softlink '.p10k.zsh'
softlink 'com.googlecode.iterm2.plist'
