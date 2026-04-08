#!/usr/bin/env bash

# GUI applications

set -xe

# Use apt by default (debian/ubuntu), or dnf for fedora
PKG=apt
if command -v dnf &> /dev/null; then
  PKG=dnf
fi

sudo $PKG update

# Fedora only needs meld and alacritty

# gui
sudo $PKG install -y \
  meld \
  peek \
  redshift \
  xclip

if ! sudo $PKG install -y keyd; then
  # Build keyd from source when the distro package is unavailable.

  mkdir -p "$HOME/software"

  rm -rf "$HOME/software/keyd"
  git clone https://github.com/rvaiya/keyd.git "$HOME/software/keyd"

  make -C "$HOME/software/keyd"
  sudo make -C "$HOME/software/keyd" install
fi

sudo mkdir -p /etc/keyd
sudo tee /etc/keyd/default.conf > /dev/null <<'EOF'
[ids]
*

[main]
capslock = overload(control, esc)
EOF

sudo systemctl enable --now keyd

if command -v gsettings &> /dev/null ; then
  gsettings set org.gnome.desktop.peripherals.keyboard delay 200
  gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 20
fi

# Do not rely on snap with pop-os

# Cannot merge into single line
#sudo snap install alacritty --classic
#sudo snap install code --classic
#sudo snap install drawio --classic
#sudo snap install emacs --classic
#sudo snap install slack --classic

stow alacritty
# stow code

# Works by default on pop-os 22.04
# Working alt-shift-tab
# gsettings reset org.gnome.desktop.input-sources xkb-options

# Works by default on pop-os 22.04
# Improve double-click word selection
# https://unix.stackexchange.com/questions/290544/double-click-selection-in-gnome-terminal
# puuid=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
# gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$puuid/ word-char-exceptions '@ms "-=&#:/.?@+~_%;"'
