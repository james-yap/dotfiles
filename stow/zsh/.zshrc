# ~/.zshrc - Main entry point for Zsh configuration

# Define Zsh configuration directory
export ZSH_CONFIG="$HOME/.config/zsh"

# Source modular configurations
if [[ -d "$ZSH_CONFIG" ]]; then
  # Load all modular configuration files (using nullglob 'N' suffix)
  for config_file in "$ZSH_CONFIG"/*.zsh(N); do
    source "$config_file"
  done
  unset config_file
fi
