set -xe

mkdir -p ~/software

# todo - conditionally skip some of these steps
wget https://github.com/neovim/neovim/releases/download/v0.5.1/nvim.appimage -P ~/software
chmod u+x ~/software/nvim.appimage
sudo ln -s ~/software/nvim.appimage /usr/local/bin/nvim
sudo ln -s /usr/local/bin/nvim /usr/local/bin/vim
sudo ln -s /usr/local/bin/nvim /usr/local/bin/vi

# clear old configs:
#rm -rf ~/.config/nvim/bundle
#rm ~/.config/nvim

stow nvim
mkdir -p ~/.config/nvim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim

nvim --headless +PluginInstall +qa

