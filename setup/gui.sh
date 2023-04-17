#!/usr/bin/env bash

# GUI applications

set -xe

sudo apt update
sudo apt upgrade

# gui
sudo apt install -y \
  meld \
  peek \
  redshift \
  xcape \
  xclip

# Cannot merge into single line
sudo snap install alacritty --classic
sudo snap install code --classic
sudo snap install drawio --classic
sudo snap install emacs --classic
sudo snap install slack --classic

stow alacritty
stow code

# Working alt-shift-tab
gsettings reset org.gnome.desktop.input-sources xkb-options

# Improve double-click word selection
# https://unix.stackexchange.com/questions/290544/double-click-selection-in-gnome-terminal
puuid=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$puuid/ word-char-exceptions '@ms "-=&#:/.?@+~_%;"'
