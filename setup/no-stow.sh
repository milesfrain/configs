# Minimal setup for systems which do not have stow

set -xe

dir=$(dirname $(realpath $0))

dotfiles=(
    "$dir"/tmux/.tmux.conf
    "$dir"/tmux/.reset.tmux.conf
    "$dir"/zsh/.zshrc
)

# Setup symlinks to dotfiles (workaround when stow is not available)
for d in "${dotfiles[@]}"
do
  ln -s "$d" ~/$(basename "$d")
done

"$dir"/get-tmux-rst.sh

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

# ./vim_setup.sh

echo Run the following command, then log out and in:
echo chsh -s $(which zsh)
