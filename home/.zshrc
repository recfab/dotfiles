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

DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  # asdf
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
  mvn
)
plugins+=(zsh-better-npm-completion)

# Setup FPATH so that completions work. Must be before sourcing `oh-my-zsh.sh` because that script automatically calls compinit
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='mvim'
else
  export EDITOR='vim'
fi

# alias gpmr='git push --set-upstream origin $(git_current_branch) --push-option merge_request.create'

# TODO A lot of this is HubSpot stuff that can be archived
alias du="du -I'.git' -h -d1"
alias k="kubectl"
alias ke="k exec -it"
# alias nvto='kubectl get pods -l component=vitess-operator -o name | cut -d / -f 2'
# alias vtol='kubectl logs -f $(nvto) -c vto'
alias kns="k config set-context --current --namespace"
# alias knsc="kns vt-chaos"
# alias knsg="kns vt-green"
# alias knsb="kns vt-blue"
# alias knsp="k use iad03-test -n vt-$USER"

export COL_NAME='Name:.metadata.name'
# export COL_OWNING_TEAM='OwningTeam:.spec.owningTeam'
# export COL_CRITICALITY='Criticality:".metadata.annotations.vitess\.hubspot\.com/reliability-qos"'
export COL_PHASE='Status:.status.phase'
export COL_STORAGE_CLASS='StorageClass:.spec.storageClass'
export COL_PERF_CLASS='PerfClass:.spec.performanceClass'

# alias kgetks-failed="k get ks -ocustom-columns=Name:.metadata.name,Status:.status.phase | grep -E -v -e 'Running|Deploying'"
# alias kgetvtgp-failed="k get vtgp -ocustom-columns=Name:.metadata.name,Status:.status.phase | grep -E -v -e 'Running|Deploying'"
# alias kgetks-wide="k get ks -ocustom-columns=Name:.metadata.name,Status:.status.phase,StorageCls:.spec.storageClass,PerfCls:.spec.performanceClass,InMigration:.spec.inMigration"

alias kyaml="k get -o yaml"
# alias di="kubectl-datainfra"
# alias tf="terraform"
# alias tfval="terraform validate"
# alias tfpo="terraform plan -out=plan.tfplan"
# alias tflock="terraform providers lock -platform=windows_amd64 -platform=darwin_amd64 -platform=linux_amd64"
# alias v="tls-vtctlclient"

# function kgetks-not-ready() {
#   keyspace="$1"
#   ns="$2"
#   k get pods -lkeyspace=$keyspace -n "$ns" -o jsonpath='{.items[*].status.containerStatuses[?(@.ready == false)] }' | jq
# }

## Crio
alias auth="gcloud auth login --update-adc; npx google-artifactregistry-auth;"
alias sql-proxy-prod-us="cloud_sql_proxy -instances=crio-canada:us-east1:crio-mysql=tcp:3307"
alias sql-proxy-qa="cloud_sql_proxy -instances=crio-dev-267118:us-east1:dev-mysql=tcp:3307"
alias pf-crio-auth="kubectl -n edc port-forward deploy/crio-authentication 8081:8080"
alias pf-recruitment-api="kubectl -n recruitment-api port-forward deploy/recruitment-api 8082:8080"
alias mcc="mvn clean compile"
## /Crio

alias gdtd="git difftool --dir-diff"
alias gfix="git commit --fixup HEAD"

alias date-id="date '+%Y%m%d%H%M%S'"
alias date-iso="date '+%Y-%m-%d'"
alias date-long="date '+%A, %B %e, %Y'"

function current_quarter() {
  date +"%Y %m" | awk '{printf ("%4d-Q%1d\n", $1, ($2/4)+1)}'
}


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

# eval "$(asdf exec direnv hook zsh)"
# direnv() { asdf exec direnv "$@"; }

# export JAVA_HOME=$(/usr/libexec/java_home)

export PATH="/usr/local/opt/make/libexec/gnubin:/usr/local/opt/openssl/bin:$PATH"

# export GOPATH="$HOME/go"
# export PATH="$GOPATH/bin:$PATH"

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

# source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yaelnamen/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yaelnamen/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yaelnamen/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yaelnamen/google-cloud-sdk/completion.zsh.inc'; fi

# Jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$(yarn global bin):$PATH"

# Ant
export ANT_HOME="$HOME/projects/apache-ant-1.10.14"
export PATH="$ANT_HOME/bin:$PATH"

# uv
if [ -x "$(command -v uv)" ]; then
  eval "$(uv generate-shell-completion zsh)"
  eval "$(uvx --generate-shell-completion zsh)"
fi

# mise
if [ -x "$(command -v mise)" ]; then
  eval "$(mise activate zsh)"
fi

# zoxide
eval "$(zoxide init zsh)"