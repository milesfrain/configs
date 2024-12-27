#!/usr/bin/env sh

set -xe

if [ $(uname -m) = x86_64 ]; then
  # Install latest appimage
  NVIM_PATH=~/software/nvim.appimage
  NVIM_DIR=$(dirname $NVIM_PATH)
  mkdir -p $NVIM_DIR
  wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -P $NVIM_DIR
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
