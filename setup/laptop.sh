#!/usr/bin/env bash

# Laptop-specific setup

set -xe

# laptop
sudo apt install -y \
  tlp

# Show battery percentage
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Set charge threshold
# This may only work on thinkpads
sudo tlp-stat -b
sudo tlp setcharge 60 80 || true
sudo tlp-stat -b
