# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Todo, investigate antigen if plugins become annoying to manage

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Set fzf installation directory path
export FZF_BASE=~/.fzf

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    fzf
    git
    nvm # Includes what install script attempts to append to .zshrc
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

# User configuration

# This is automatically added by fzf install
# Don't know if this is necessary if also using the above plugin
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'
# Editor for vi mode (launch with vv in normal mode).
# Defaults to $EDITOR if unset.
export ZVM_VI_EDITOR='nvim -c "set wrap"'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Added by Nix installer
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi

# Checks if program exists
function has () {
    type $1 > /dev/null
}

# Checks if program is running
function running () {
    pgrep $1 > /dev/null
}

# Convenience alias for opening files with assigned GUI. For example:
# o some_document.pdf
if has xdg-open; then alias o='xdg-open'; fi

# Convenience alias for search all files
if has rg; then alias rga='rg --no-ignore --hidden'; fi

# Map capslock key to escape
# Only reconfigure if applications exist and xcape is not already running
if has setxkbmap && has xcape && ! running xcape; then setxkbmap -option ctrl:nocaps; xcape -e 'Control_L=Escape'; fi

# Keyboard repeat rate
# Do not run if there is no active display. That would spam an error.
if has xset && test "$DISPLAY"; then xset r rate 200 50; fi

alias b='~/configs/scripts/bits.py'
alias tap='~/configs/scripts/yubikey-enable.sh'
alias notap='~/configs/scripts/yubikey-enable.sh foo'
# rebase onto the default branch (e.g. main, master, develop, etc.)
function grod () {
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    common_ancestor=$(git merge-base HEAD $default_branch)
    git rebase --onto $default_branch $common_ancestor
}

# https://github.com/Wilfred/difftastic
# cargo install difftastic
# https://difftastic.wilfred.me.uk/git.html
# Use with: diff, log -p, show
gt() {
    GIT_EXTERNAL_DIFF=difft git $1 --ext-diff $@[2,-1]
}

# Pipe cargo output to pager and preserve colors
cargol() {
    cargo $@ --color always 2>&1 | less -r
}

# Example:
# rename old new
function rename() {
    rg -F $1 -l | xargs -d '\n' sd $1 $2
}

# Simple search with colored results piped to less
function rgless() {
  rg --color always $1 | less -R
}

function epoch () {
    date --reference=$1 +%s
}

# https://superuser.com/a/796341
function remove_line_breaks_from_clipboard() {
    # Clipboard with -b
    xsel -b | \
        sed 's/\.$/.|/g' | sed 's/^\s*$/|/g' | tr '\n' ' ' | tr '|' '\n' | \
        xsel -ib

    # Primary selection (highlight + middle click) by default
    xsel | \
        sed 's/\.$/.|/g' | sed 's/^\s*$/|/g' | tr '\n' ' ' | tr '|' '\n' | \
        xsel -i
}

function pipreinstall () {
     pip install --ignore-installed --no-deps "$@"
}

# Produces sorted list of duplicated basenames in tree.
# Useful for finding common files to ignore
function namecount() {
    find . -type f -printf "%f\n" | sort | uniq -cd | sort -n
}

# todo - would be great to sort by size, rather than extension
function typesize () {
  ftypes=($(find . -type f | grep -E ".*\.[a-zA-Z0-9]*$" | sed -e 's/.*\(\.[a-zA-Z0-9]*\)$/\1/' | sort | uniq))

    for ft in "${ftypes[@]}"
    do
        echo -ne "$ft\t"
        find . -name "*${ft}" -exec du -bcsh {} \; | tail -1 | sed 's/\stotal//'
    done
}

# Run this additional setup script if it exists in the local directory
if [ -f zshrc-extra.zsh ]; then source zshrc-extra.zsh; fi

#source /opt/ros/galactic/setup.zsh

# Fix autocompletion
# https://github.com/ros2/ros2cli/issues/534
# argcomplete for ros2 & colcon
#eval "$(register-python-argcomplete3 ros2)"
#eval "$(register-python-argcomplete3 colcon)"
#source ~/software/git-subrepo/.rc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
