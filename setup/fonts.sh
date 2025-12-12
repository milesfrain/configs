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

font_name=MesloLGSDZNerdFont
font_root=~/.local/share/fonts
font_path=$font_root/$font_name
# download fonts and move to ~/.local/share/fonts if not already there
if [ ! -d $font_path ]; then
  mkdir -p $font_root
  cp -r fonts/$font_name $font_root
else
  echo Font already exists. Did not overwrite. $font_path
  exit 1
fi

# install fonts
fc-cache -f -v

# Will appear immediately in system fonts menu, but may need to restart terminal, or logout for new font to be available in terminal.
