#!/usr/bin/env bash

# Core tools for working with the system

set -xe

# Link tmux config
stow tmux

# Use our linked .zshrc, rather than the one provied by oh-my-zsh
stow zsh

# Copy bash history to zsh histoy
cat ~/.bash_history | python3 bash-to-zsh-hist.py >> ~/.zsh_history

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc
