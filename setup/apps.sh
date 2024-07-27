#!/usr/bin/env bash

# Additional apps

set -xe

sudo apt update

sudo apt install -y \
  build-essential \
  cmake \
  minicom \
  python-is-python3 \
  python3-pip \
  units \
  can-utils \
  curl \
  git \
  htop \
  libfuse2 \
  mlocate \
  pv \
  stress-ng \
  lm-sensors \
  ripgrep \
  socat \
  tree

stow gdb

# Minicom setup
sudo adduser $USER dialout
sudo touch /etc/minicom/minirc.dfl
sudo chown root:dialout /etc/minicom/minirc.dfl
sudo chmod 664 /etc/minicom/minirc.dfl

# Install go disk usage (faster than ncdu)
curl -L https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | tar xz
chmod +x gdu_linux_amd64
sudo mv gdu_linux_amd64 /usr/bin/gdu

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz

# Install node via nvm
# Set PROFILE=/dev/null to tell setup script to not edit .zshrc.
# Completions are handled by nvm zsh plugin.
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash'
# Load nvm without relaunching terminal
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install stable

# Install markdown viewer
pip install mdv

# Install CPU temperature and fan monitor
pip install s-tui --user
# Probably should run these sensor setup commands manually:
#   sudo sensors-detect
#   sudo systemctl restart kmod
# Then s-tui should be able to detect fan speed
# Troubleshoot by checking output of:
#   sensors

# Install rust
curl https://sh.rustup.rs -sSf | sh

# Install helix
stow helix
mkdir -p ~/software
git clone --recurse-submodules --shallow-submodules -j8 https://github.com/helix-editor/helix ~/software/helix
pushd ~/software/helix
cargo install --path helix-term --locked
ln -s $(realpath runtime) ~/.config/helix/runtime
popd

# Install watchexec (via rust/cargo)
cargo install watchexec-cli

cargo install difftastic

cargo install sd

# To automatically install parsers in astrovim
cargo install tree-sitter-cli

# Install a better htop
cargo install bottom --locked
