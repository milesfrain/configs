# base setup

set -xe

sudo apt install -y \
  can-utils \
  curl \
  git \
  htop \
  ncdu \
  mlocate \
  pv \
  ripgrep \
  socat \
  stow \
  tree \
  tmux \
  zsh

stow tmux
./get-tmux-rst.sh

# stow nvim (handled in vim_setup.sh)
# Use our linked .zshrc, rather than the one provied by oh-my-zsh
stow zsh

# zsh
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode

# fzf
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

./vim_setup.sh

echo Run the following command, then log out and in:
echo chsh -s $(which zsh)
