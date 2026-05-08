ZSH_THEME=""

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

eval "$(starship init zsh)"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '^[[C' autosuggest-accept