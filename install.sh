set -xe

sudo apt update
sudo apt upgrade

sudo apt install \
  build-essential \
  git \
  htop \
  meld \
  mlocate \
  peek \
  redshift \
  ripgrep \
  stow \
  tlp \
  tree \
  tmux \
  units \
  xcape \
  xclip \
  zsh

# Cannot merge into single line
sudo snap install alacritty --classic
sudo snap install code --classic
sudo snap install drawio --classic
sudo snap install emacs --classic
sudo snap install slack --classic

stow core
mkdir -p ~/.config/nvim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
stow nvim_stow

mkdir -p ~/software

# neovim setup
wget https://github.com/neovim/neovim/releases/download/v0.5.1/nvim.appimage -P ~/software
chmod u+x ~/software/nvim.appimage
sudo ln -s ~/software/nvim.appimage /usr/local/bin/nvim
sudo ln -s /usr/local/bin/nvim /usr/local/bin/vim
sudo ln -s /usr/local/bin/nvim /usr/local/bin/vi
nvim +'PluginInstall' +qa

# zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

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
