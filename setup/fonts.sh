#!/usr/bin/env bash

# Install NerdFonts
# There are many sources for these fonts.
# In this case, we're grabbing from pl10k project.
#
# Note that this also requires configuring the terminal to use these fonts.
# See this pages for instructions for your terminal:
# https://github.com/romkatv/powerlevel10k#manual-font-installation
#
# GNOME terminal:
#   Preferences, Appearance, Font, MesloLGS Regular
#
# Alacritty:
#   todo
#
# For reference, GNOME terminal default is 'Fira Mono Regular'

set -xe

# download fonts and move to ~/.local/share/fonts if not already there
if [ ! -d ~/.local/share/fonts/mesloLGS_NF ]; then
  mkdir -p ~/.local/share/fonts/mesloLGS_NF
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -O ~/.local/share/fonts/mesloLGS_NF/MesloLGS\ NF\ Regular.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -O ~/.local/share/fonts/mesloLGS_NF/MesloLGS\ NF\ Bold.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -O ~/.local/share/fonts/mesloLGS_NF/MesloLGS\ NF\ Italic.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -O ~/.local/share/fonts/mesloLGS_NF/MesloLGS\ NF\ Bold\ Italic.ttf
fi

# install fonts
fc-cache -f -v

# Will appear immediately in system fonts menu, but may need to restart terminal, or logout for new font to be available in terminal.
