# Shell configuration and tool integrations

# Initialize zoxide (smarter cd)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Initialize fzf (command-line fuzzy finder)
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi
