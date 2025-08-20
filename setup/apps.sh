#!/usr/bin/env bash

# Additional apps

set -xe

# Use apt by default (debian/ubuntu), or dnf for fedora
APT=apt
if command -v dnf &> /dev/null; then
  # fedora
  APT=dnf
  sudo $APT update
  sudo $APT install -y \
    @development-tools \
    gcc-c++ \
    lm_sensors
else
  # ubuntu
  sudo $APT update
  sudo $APT install -y \
    build-essential \
    curl \
    git \
    htop \
    lm-sensors \
    python-is-python3 \
    tree
fi

# common
sudo $APT install -y \
  cmake \
  minicom \
  units \
  can-utils \
  pv \
  python3-pip \
  stress-ng \
  ripgrep \
  socat

stow gdb

# Minicom setup

# hacky way to check for fedora
if command -v dnf &> /dev/null; then
  # fedora
  sudo usermod -a -G dialout $USER
  # no intermediate directory
  sudo touch /etc/minirc.dfl
  sudo chown root:dialout /etc/minirc.dfl
  sudo chmod 664 /etc/minirc.dfl
else
  # ubuntu
  sudo adduser $USER dialout
  # uses intermediate directory
  sudo touch /etc/minicom/minirc.dfl
  sudo chown root:dialout /etc/minicom/minirc.dfl
  sudo chmod 664 /etc/minicom/minirc.dfl
fi

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
echo Installing node and nvm without tracing
set +x # disable tracing for spammy command
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install stable
set -x # re-enable tracing

# Need to use pipx (or alternative) instead of pip to install on
# Python 3.11+ systems (Ubuntu 23+).
# Can generate helpful error message with old pip attempt.

# Install markdown viewer
#pip install mdv

# Install CPU temperature and fan monitor
#pip install s-tui --user
# Probably should run these sensor setup commands manually:
#   Todo: Try running s-tui without these first
#   sudo sensors-detect
#   sudo systemctl restart kmod
# Then s-tui should be able to detect fan speed
# Troubleshoot by checking output of:
#   sensors

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Make rust temporarily available in the current shell so the following commands work
. "$HOME/.cargo/env"

# Need to install the real version of rust-analyzer manually
rustup component add rust-analyzer

# Install helix
# stow helix

# Just rely on distro-packaged version instead
# mkdir -p ~/software
# git clone --recurse-submodules --shallow-submodules -j8 https://github.com/helix-editor/helix ~/software/helix
# pushd ~/software/helix
# cargo install --path helix-term --locked
# ln -s $(realpath runtime) ~/.config/helix/runtime
# popd
 
# Install watchexec (via rust/cargo)
cargo install watchexec-cli

cargo install difftastic

cargo install sd

# To automatically install parsers in astrovim
cargo install tree-sitter-cli

# Install a better htop
cargo install bottom --locked
