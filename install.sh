apt install \
  git \
  htop \
  xcape \
  xclip \
  tmux \
  zsh \
  tlp \
  ripgrep \
  build-essential \
  mlocate \
  units \
  meld

snap install code --classic
#snap install slack --classic

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# show battery percentage
gsettings set org.gnome.desktop.interface show-battery-percentage true

# set charge threshold
sudo tlp-stat -b
sudo tlp setcharge 60 80
sudo tlp-stat -b
