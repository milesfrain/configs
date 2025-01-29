#!/usr/bin/env bash

# Core tools for working with the system

set -xe

# Use apt by default (debian/ubuntu), or dnf for fedora
APT=apt
if command -v dnf &> /dev/null; then
    APT=dnf
fi

sudo $APT update

sudo $APT install -y \
  stow \
  tmux \
  zsh

stow git

stow tmux
./get-tmux-rst.sh

# Some plugins (CPU monitor) require cmake, which is installed in setup/apps.sh
# But tmux will still work fine without it.
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
TMUX_PLUGIN_MANAGER_PATH=~/.tmux/plugins ~/.tmux/plugins/tpm/bin/install_plugins
# need to run this within tmux
# ~/.tmux/plugins/tpm/bin/install_plugins

# Use our linked .zshrc, rather than the one provied by oh-my-zsh
stow zsh

# zsh
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

stow p10k

# fzf
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

user=$(whoami)
sudo chsh -s $(which zsh) $user
