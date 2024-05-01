# shellcheck shell=bash

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# make sure we can find brew
eval $(/opt/homebrew/bin/brew shellenv)

export ZSH=~/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  asdf
  aws
  colored-man-pages
  docker
  # docker-compose
  # doctl
  dotnet
  fzf
  git
  git-auto-fetch
  git-extras
  kubectl
  # rust
  zsh-autosuggestions
)

# Setup FPATH so that completions work. Must be before sourcing `oh-my-zsh.sh` because that script automatically calls compinit
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='mvim'
else
  export EDITOR='code --wait'
fi

# alias gpmr='git push --set-upstream origin $(git_current_branch) --push-option merge_request.create'

alias du="du -I'.git' -h -d1 ."
alias k="hs-kubectl"
alias ke="k exec -it"
alias nvto='kubectl get pods -l component=vitess-operator -o name | cut -d / -f 2'
alias vtol='kubectl logs -f $(nvto) -c vto'
alias kns="k config set-context --current --namespace"
alias knsc="kns vt-chaos"
alias knsg="kns vt-green"
alias knsb="kns vt-blue"
alias knsp="k use iad03-test -n vt-$USER"

export COL_NAME='Name:.metadata.name'
export COL_OWNING_TEAM='OwningTeam:.spec.owningTeam'
export COL_CRITICALITY='Criticality:".metadata.annotations.vitess\.hubspot\.com/reliability-qos"'
export COL_PHASE='Status:.status.phase'
export COL_STORAGE_CLASS='StorageClass:.spec.storageClass'
export COL_PERF_CLASS='PerfClass:.spec.performanceClass'

alias kgetks-failed="k get ks -ocustom-columns=Name:.metadata.name,Status:.status.phase | grep -E -v -e 'Running|Deploying'"
alias kgetvtgp-failed="k get vtgp -ocustom-columns=Name:.metadata.name,Status:.status.phase | grep -E -v -e 'Running|Deploying'"
alias kgetks-wide="k get ks -ocustom-columns=Name:.metadata.name,Status:.status.phase,StorageCls:.spec.storageClass,PerfCls:.spec.performanceClass,InMigration:.spec.inMigration
"
alias kyaml="k get -o yaml"
alias di="kubectl-datainfra"
alias tf="terraform"
alias tfval="terraform validate"
alias tfpo="terraform plan -out=plan.tfplan"
alias tflock="terraform providers lock -platform=windows_amd64 -platform=darwin_amd64 -platform=linux_amd64"

function kgetks-not-ready() {
  keyspace="$1"
  ns="$2"
  k get pods -lkeyspace=$keyspace -n "$ns" -o jsonpath='{.items[*].status.containerStatuses[?(@.ready == false)] }' | jq
}

alias gdtd="git difftool --dir-diff"

alias date-id="date '+%Y%m%d%H%M%S'"
alias date-iso="date '+%Y-%m-%d'"
alias date-long="date '+%A, %B %e, %Y'"

alias v="tls-vtctlclient"

gh-ref() {
  echo "$1" | awk -F'/' -vOFS='' '{ print $(NF-3),"/",$(NF-2),"#",$(NF) }'
}

gh-ref-link() {
  ref=$(gh-ref "$1")
  echo "[$ref]($1)"
}

jira-ref() {
  echo "$1" | awk -F'/' -vOFS='' '{ print $(NF) }'
}

jira-ref-link() {
  ref=$(jira-ref "$1")
  echo "[$ref]($1)"
}

shell_info() {
  echo "AWS profile: $AWS_PROFILE"
  echo "AWS default region: $(aws configure get region)"

  echo "kubie ctx  : $(kubie info ctx)"
  echo "kubie ns   : $(kubie info ns)"
  echo "kubie depth: $(kubie info depth)"
}

eval "$(asdf exec direnv hook zsh)"
direnv() { asdf exec direnv "$@"; }

# export JAVA_HOME=$(/usr/libexec/java_home)

export PATH="/usr/local/opt/make/libexec/gnubin:/usr/local/opt/openssl/bin:$PATH"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

export PATH="$HOME/bin:$PATH"

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/Users/nameny/Library/Python/3.9/bin:$PATH"
export PATH="$PATH:/Users/nameny/.dotnet/tools"
export PATH="$HOME/.local/bin:$PATH"

# shellcheck source=~/.cargo/env
# source "$HOME/.cargo/env"

# The following lines were added by compinstall
zstyle :compinstall filename '/home/yael/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Added by nex: https://git.hubteam.com/HubSpot/nex
. ~/.hubspot/shellrc

# export PATH="/opt/homebrew/opt/hshs/bin:$PATH"
export PATH="/opt/homebrew/opt/go@1.19/bin:$PATH"
export GOPRIVATE="git.hubteam.com"

export PATH="$(go env GOPATH)/src/git.hubteam.com/hubspot/vitess-upstream/bin:$PATH"
export PATH="$(go env GOPATH)/src/git.hubteam.com/hubspotprotected/vitess-internal/python/tls_vtctlclient:$PATH"
