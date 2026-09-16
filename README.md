# Yael Namen's Dotfiles

## Setup

Stow packages: `core` (always), plus one domain package for machine-specific
config — `crio` or `personal`. `core` provides the framework (it sources
`~/.config/zsh/env.d/*.zsh` and `~/.config/zsh/rc.d/*.zsh`); each domain
package just drops a file there.

```
./kickstart.sh          # core only
./kickstart.sh crio     # core + crio
./kickstart.sh personal # core + personal
```

## Applications to install on a new computer

- asdf
  - terraform
  - kubectl
  - direnv
- brew
  - nodejs
- npm global
  - diff-so-fancy
- 1password
- From App Store
  - moom
  - greenshot
  - wallpaperer
  - spark
- `.dmg`
  - beyond compare https://www.scootersoftware.com/download.php
  - spotify
