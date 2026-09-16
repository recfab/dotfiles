# Tokens / secrets
export JIRA_API_TOKEN=$(cat ~/.local/share/secrets/jira-cli 2>/dev/null)
export FONTAWESOME_NPM_AUTH_TOKEN=$(cat ~/.local/share/secrets/fontawesometoken 2>/dev/null)
# Expose to macOS GUI apps (no-op outside a user login session)
launchctl setenv JIRA_API_TOKEN "$JIRA_API_TOKEN" 2>/dev/null || true

# jenv bin (init hook stays in .zshrc — too slow for every shell)
export PATH="$HOME/.jenv/bin:$PATH"

# Ant
export ANT_HOME="$HOME/projects/apache-ant-1.10.14"
export PATH="$ANT_HOME/bin:$PATH"

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi
