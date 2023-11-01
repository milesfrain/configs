# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set zsh theme
ZSH_THEME="robbyrussell"

# Set fzf installation directory path
export FZF_BASE=~/.fzf

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    fzf
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Disable omzsh auto-update (must be before sourcing)
zstyle ':omz:update' mode disabled

source $ZSH/oh-my-zsh.sh

# Prefix prompt with machine name (%m)
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Login-information
# This should occur after oh-my-zsh.sh is sourced, which sets the PROMPT variable
PROMPT="%{$fg[magenta]%}%m"${PROMPT}

# Fix omz slow pasting
# https://github.com/zsh-users/zsh-syntax-highlighting/issues/295#issuecomment-214581607
zstyle ':bracketed-paste-magic' active-widgets '.self-*'
