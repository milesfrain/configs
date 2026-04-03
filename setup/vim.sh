#!/usr/bin/env sh

set -xe

case "$(uname -s)" in
  Linux)
    nvim_os="linux"
    nvim_ext="appimage"
    ;;
  *)
    echo "Unsupported OS: $(uname -s)" >&2
    exit 1
    ;;
esac

case "$(uname -m)" in
  x86_64)
    nvim_arch="x86_64"
    ;;
  aarch64|arm64)
    nvim_arch="arm64"
    ;;
  *)
    echo "Unsupported architecture: $(uname -m)" >&2
    exit 1
    ;;
esac

# Install latest supported release asset for this platform.
NVIM_VERSION="v0.12.0"
NVIM_PATH="$HOME/software/nvim.appimage"
NVIM_DIR=$(dirname "$NVIM_PATH")
NVIM_ASSET="nvim-${nvim_os}-${nvim_arch}.${nvim_ext}"

mkdir -p "$NVIM_DIR"
wget "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${NVIM_ASSET}" -O "$NVIM_PATH"
chmod u+x "$NVIM_PATH"
sudo update-alternatives --install /usr/bin/ex ex "${NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vi vi "${NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/view view "${NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/nvim nvim "${NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vimdiff vimdiff "${NVIM_PATH}" 110

# Setup astrovim
# This is all tracked in user config, but can use this command to start fresh.
# git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim

# Link user config
stow nvim
# Ignore this error, occurs even when checking version
#   Possible precedence issue with control flow operator (exit) at /usr/bin/stow line 839, <DATA> line 23.
#   stow -V
#   stow (GNU Stow) version 2.4.0
