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
  ncdu \
  mlocate \
  pv \
  ripgrep \
  socat \
  tree

./vim_setup.sh

# Minicom setup
sudo adduser $USER dialout
sudo touch /etc/minicom/minirc.dfl
sudo chown root:dialout /etc/minicom/minirc.dfl
sudo chmod 664 /etc/minicom/minirc.dfl

# Install rust
curl https://sh.rustup.rs -sSf | sh

# Install helix
git clone --recurse-submodules --shallow-submodules -j8 https://github.com/helix-editor/helix
pushd helix
cargo install --path helix-term
ln -s $(realpath runtime) ~/.config/helix/runtime
popd
stow helix

# Install watchexec (via rust/cargo)
cargo install watchexec-cli
