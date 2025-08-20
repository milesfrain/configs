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
# On one system install, it encountered an "unknown variable: TMUX_PLUGIN_MANAGER_PATH" error.
# Like this https://github.com/tmux-plugins/tpm/issues/248
# But I think that was due to another old instance of tmux running.
# I didn't see it in the process list, but found one via `tmux attach`.
TMUX_PLUGIN_MANAGER_PATH=~/.tmux/plugins ~/.tmux/plugins/tpm/bin/install_plugins
# Likely outdated instruction: "need to run this within tmux"
# ~/.tmux/plugins/tpm/bin/install_plugins

# This manual approach works well:
# Launch tmux, make sure config is loaded, and install plugins with:
# <prefix> + I
# https://github.com/tmux-plugins/tpm?tab=readme-ov-file#installing-plugins

# Use our linked .zshrc, rather than the one provied by oh-my-zsh
stow zsh

# zsh
rm -rf ~/.oh-my-zsh
set +x # disable echo for noisy omzsh install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
set -x # re-enable echo
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
