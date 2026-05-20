# Fish-like behavior configurations (autosuggestions, syntax highlighting, and prompt)

# Initialize Starship prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# Sourcing homebrew-installed plugins
if command -v brew >/dev/null 2>&1; then
  local brew_prefix
  brew_prefix="$(brew --prefix)"

  if [[ -f "$brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi

  if [[ -f "$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  fi
fi

# Accept autosuggestions with right arrow or Ctrl+F
bindkey '^[[C' autosuggest-accept
bindkey '^F' autosuggest-accept
