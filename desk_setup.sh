# desk setup

set -xe

sudo apt update
sudo apt upgrade

./base_setup.sh

sudo apt install \
  build-essential \
  meld \
  peek \
  redshift \
  tlp \
  units \
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
stow git

# show battery percentage
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Working alt-shift-tab
gsettings reset org.gnome.desktop.input-sources xkb-options

# set charge threshold
sudo tlp-stat -b
sudo tlp setcharge 60 80
sudo tlp-stat -b

curl https://sh.rustup.rs -sSf | sh
cargo install watchexec-cli
