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
    zsh-vi-mode
)

# Fix compatibility issues with fzf and vi-mode (e.g. reverse search rebinding)
# zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

source $ZSH/oh-my-zsh.sh

# Fix omz slow pasting
# https://github.com/zsh-users/zsh-syntax-highlighting/issues/295#issuecomment-214581607
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# Editor for vi mode (launch with vv in normal mode).
export EDITOR='vi'
