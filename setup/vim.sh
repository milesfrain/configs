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
NVIM_PATH="/usr/local/bin/nvim"
NVIM_ASSET="nvim-${nvim_os}-${nvim_arch}.${nvim_ext}"

# Finish downloading before replacing the installed executable.
nvim_download=$(mktemp)
trap 'rm -f "$nvim_download"' 0
trap 'exit 1' HUP INT TERM
wget "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${NVIM_ASSET}" -O "$nvim_download"
sudo install -d -m 0755 /usr/local/bin
sudo install -o root -g root -m 0755 "$nvim_download" "$NVIM_PATH"

# Register shared candidates; preserve manually selected alternatives.
for name in ex vi view nvim vimdiff; do
  sudo update-alternatives --install "/usr/bin/$name" "$name" "$NVIM_PATH" 110
done

# Setup astrovim
# This is all tracked in user config, but can use this command to start fresh.
# git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim

# Link user config
stow nvim
# Ignore this error, occurs even when checking version
#   Possible precedence issue with control flow operator (exit) at /usr/bin/stow line 839, <DATA> line 23.
#   stow -V
#   stow (GNU Stow) version 2.4.0
