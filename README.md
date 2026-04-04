### For a super basic setup:

See the `basic` branch:
https://github.com/milesfrain/configs/tree/basic

### For a more fully-featured setup:

Clone this repo and run the `core` setup script:
```sh
git clone --recursive https://github.com/milesfrain/configs.git ~/configs
cd ~/configs
setup/core.sh
```

You may need to manually change the default shell to `zsh` by running the following, and logging out and in:
```sh
chsh -s $(which zsh)
```

You can then run additional setup scripts depending on what you want to install:
```sh
setup/apps.sh
setup/vim.sh # needs tree-sitter-cli, installed in apps.sh above. Start new terminal so npm is picked-up.
setup/gui.sh
setup/laptop.sh
```

You may need to install additional fonts on your local machine:
```sh
setup/fonts.sh
```

If your system does not have `stow`, you can still install a minimal config with:
```sh
setup/no-stow.sh
```

When migrating to a new tmux version, you can update reference default settings by running:
```sh
./get-tmux-rst.sh
```
