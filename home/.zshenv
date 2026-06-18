# .zshenv — loaded by ALL zsh invocations (interactive, non-interactive, login, scripts).
# Keep this fast: no aliases, no completions, no prompts, no heavy evals.
# Interactive-only setup (oh-my-zsh, prompt, completions) lives in .zshrc.

# Homebrew — must come first so brew-installed tools are on PATH for everything below
eval "$(/opt/homebrew/bin/brew shellenv)"

# Tokens / secrets
export JIRA_API_TOKEN=$(cat ~/.local/share/secrets/jira-cli 2>/dev/null)
export FONTAWESOME_NPM_AUTH_TOKEN=$(cat ~/.local/share/secrets/fontawesometoken 2>/dev/null)
# Expose to macOS GUI apps (no-op outside a user login session)
launchctl setenv JIRA_API_TOKEN "$JIRA_API_TOKEN" 2>/dev/null || true

# Claude Code settings
export ENABLE_TOOL_SEARCH=true

# PATH — ordered from highest to lowest priority
export PATH="/usr/local/opt/make/libexec/gnubin:/usr/local/opt/openssl/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# jenv bin (init hook stays in .zshrc — too slow for every shell)
export PATH="$HOME/.jenv/bin:$PATH"

# mise shims — resolves mise-managed tools (node, python, java, etc.) in non-interactive shells
# Interactive shells also run `mise activate zsh` in .zshrc for dynamic version switching
export PATH="$HOME/.local/share/mise/shims:$PATH"

# Ant
export ANT_HOME="$HOME/projects/apache-ant-1.10.14"
export PATH="$ANT_HOME/bin:$PATH"

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi
