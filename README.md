Clone this repo, then run:
```
setup/core.sh
```

You may need to manually change the deault shell to `zsh` by running the following, and logging out and in:
```
chsh -s $(which zsh)
```

You can then run additional setup scripts depending on what you want to install:
```
setup/apps.sh
setup/gui.sh
setup/laptop.sh
```

If your system does not have `stow`, you can still install a minimal config with:
```
setup/no-stow.sh
```

When migrating to a new tmux version, you can update reference default settings by running:
```
setup/get-tmux-rst.sh
```
