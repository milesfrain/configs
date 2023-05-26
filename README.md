### For a super basic setup:

See the `basic` branch:
https://github.com/milesfrain/configs/tree/basic

### For a more fully-featured setup:

Clone this repo and run the `core` setup script:
```
git clone https://github.com/milesfrain/configs.git ~/configs
cd ~/configs
setup/core.sh
```

You may need to manually change the default shell to `zsh` by running the following, and logging out and in:
```
chsh -s $(which zsh)
```

You can then run additional setup scripts depending on what you want to install:
```
setup/apps.sh
setup/gui.sh
setup/laptop.sh
```

You may need to install additional fonts on your local machine:
```
setup/fonts.sh
```

If your system does not have `stow`, you can still install a minimal config with:
```
setup/no-stow.sh
```

When migrating to a new tmux version, you can update reference default settings by running:
```
./get-tmux-rst.sh
```
