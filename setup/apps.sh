#!/usr/bin/env bash

# Additional apps

set -xe

sudo apt update

sudo apt install -y \
  build-essential \
  minicom \
  python-is-python3 \
  units \
  can-utils \
  curl \
  git \
  htop \
  libfuse2 \
  ncdu \
  mlocate \
  pv \
  ripgrep \
  socat \
  tree

setup/vim.sh

# Minicom setup
sudo adduser $USER dialout
sudo touch /etc/minicom/minirc.dfl
sudo chown root:dialout /etc/minicom/minirc.dfl
sudo chmod 664 /etc/minicom/minirc.dfl

# Install rust
curl https://sh.rustup.rs -sSf | sh

# Install helix
stow helix
mkdir -p ~/software
git clone --recurse-submodules --shallow-submodules -j8 https://github.com/helix-editor/helix ~/software/helix
pushd ~/software/helix
cargo install --path helix-term
ln -s $(realpath runtime) ~/.config/helix/runtime
popd

# Install watchexec (via rust/cargo)
cargo install watchexec-cli
