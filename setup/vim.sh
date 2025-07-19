#!/usr/bin/env sh

set -xe

if [ $(uname -m) = x86_64 ]; then
  # Install latest appimage
  NVIM_PATH=~/software/nvim.appimage
  NVIM_DIR=$(dirname $NVIM_PATH)
  mkdir -p $NVIM_DIR
  # Grabbing latest can result in backwards compatability issues
  # wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage -O $NVIM_DIR/nvim.appimage
  wget https://github.com/neovim/neovim/releases/download/v0.10.2/nvim.appimage -O $NVIM_DIR/nvim.appimage
  chmod u+x $NVIM_PATH
  sudo update-alternatives --install /usr/bin/ex ex "${NVIM_PATH}" 110
  sudo update-alternatives --install /usr/bin/vi vi "${NVIM_PATH}" 110
  sudo update-alternatives --install /usr/bin/view view "${NVIM_PATH}" 110
  sudo update-alternatives --install /usr/bin/nvim nvim "${NVIM_PATH}" 110
  sudo update-alternatives --install /usr/bin/vimdiff vimdiff "${NVIM_PATH}" 110
else
  # Install old version, but should be fine.
  sudo apt install -y neovim
  # This should automatically set up vi and vim alternatives.
  # Might need old vim and vi to be uninstaled.
  # Todo - could add a check and an error
fi

# Setup astrovim
# This is all tracked in user config, but can use this command to start fresh.
# git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim

# Link user config
stow nvim
# Ignore this error, occurs even when checking version
#   Possible precedence issue with control flow operator (exit) at /usr/bin/stow line 839, <DATA> line 23.
#   stow -V
#   stow (GNU Stow) version 2.4.0
