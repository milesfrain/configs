#!/usr/bin/env bash

# Core tools for working with the system

set -xe

sudo apt update

sudo apt install -y \
  stow \
  tmux \
  zsh

stow tmux

# Use our linked .zshrc, rather than the one provied by oh-my-zsh
stow zsh

# zsh
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# fzf
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

# Set zsh as default shell
user=$(whoami)
sudo chsh -s $(which zsh) $user
