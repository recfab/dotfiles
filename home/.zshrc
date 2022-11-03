# shellcheck shell=bash

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=~/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  asdf
  colored-man-pages
  docker
  # docker-compose
  doctl
  dotnet
  fzf
  git
  git-auto-fetch
  git-extras
  kubectl
  rust
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='mvim'
else
  export EDITOR='code --wait'
fi

alias gpmr='git push --set-upstream origin $(git_current_branch) --push-option merge_request.create'
alias k="kubectl"
alias tf="terraform"
alias tfval="terraform validate"
alias tfpo="terraform plan -out=plan.tfplan"

alias date-id="date '+%Y%m%d%H%M%S'"
alias date-iso="date '+%Y-%m-%d'"
alias date-long="date '+%A, %B %e, %Y'"

shell_info() {
  echo "AWS profile: $AWS_PROFILE"
  echo "AWS default region: $(aws configure get region)"

  echo "kubie ctx  : $(kubie info ctx)"
  echo "kubie ns   : $(kubie info ns)"
  echo "kubie depth: $(kubie info depth)"
}

use-tabletop-dev () {
  export AWS_PROFILE=wotc-tabletop-dev
}

login-tabletop-dev () {
  saml2aws login --profile wotc-tabletop-dev --role arn:aws:iam::896850791949:role/Administrator --skip-prompt;
}

use-tabletop-prod () {
  export AWS_PROFILE=wotc-tabletop-prod
}

login-tabletop-prod () {
  saml2aws login --profile wotc-tabletop-prod --role arn:aws:iam::647651886844:role/Administrator --skip-prompt;
}

use-dps-prod () {
  export AWS_PROFILE=wotc-dps-prod
}

login-dps-prod () {
  saml2aws login --profile wotc-dps-prod --role arn:aws:iam::385520225527:role/Administrator --skip-prompt;
}

eval "$(asdf exec direnv hook zsh)"
direnv() { asdf exec direnv "$@"; }

# export JAVA_HOME=$(/usr/libexec/java_home)

export PATH="/usr/local/opt/make/libexec/gnubin:/usr/local/opt/openssl/bin:$PATH"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/Users/nameny/Library/Python/3.9/bin:$PATH"
export PATH="$PATH:/Users/nameny/.dotnet/tools"

# The following lines were added by compinstall
zstyle :compinstall filename '/home/recfab/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
