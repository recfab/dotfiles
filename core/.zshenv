# .zshenv — loaded by ALL zsh invocations (interactive, non-interactive, login, scripts).
# Keep this fast: no aliases, no completions, no prompts, no heavy evals.
# Interactive-only setup (oh-my-zsh, prompt, completions) lives in .zshrc.

# Homebrew — must come first so brew-installed tools are on PATH for everything below
eval "$(/opt/homebrew/bin/brew shellenv)"

# Claude Code settings
export ENABLE_TOOL_SEARCH=true

# PATH — ordered from highest to lowest priority
export PATH="/usr/local/opt/make/libexec/gnubin:/usr/local/opt/openssl/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" ## archived package
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# mise shims — resolves mise-managed tools (node, python, java, etc.) in non-interactive shells
# Interactive shells also run `mise activate zsh` in .zshrc for dynamic version switching
export PATH="$HOME/.local/share/mise/shims:$PATH"

# Domain-specific env config (crio, personal, ...) — each domain package drops
# a file here; core just imports whatever's present.
for f in "$HOME"/.config/zsh/env.d/*.zsh(N); do
  source "$f"
done