This `basic` branch just includes a small config for `zsh`, `fzf`, and `tmux`.
Configs are tracked using `stow`.

This does not customize any `tmux` keybindings. You can read more about the default bindings here:
https://github.com/tmux/tmux/wiki/Getting-Started

For more opinionated tmux bindings, you can follow the setup instructions in the main branch:
https://github.com/milesfrain/configs

#### Installation:

Clone the `basic` branch of this repo and run the setup script:
```
git clone https://github.com/milesfrain/configs.git --depth=1 --branch basic ~/configs
cd ~/configs
./setup.sh
```

You may need to manually change the default shell to `zsh` by running the following, and logging out and in:
```
chsh -s $(which zsh)
```
