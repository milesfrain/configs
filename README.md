For applying a desktop config, run:
```
./desk_setup.sh
```

For applying more minimal config, run:
```
./base_setup.sh
```

You may need to manually change the deault shell to `zsh` by running:
```
chsh -s $(which zsh)
```

When migrating to a new tmux version, you can update reference default settings by running:
```
./get-tmux-rst.sh
```
