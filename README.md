### For a super basic setup:

See the `basic` branch:
https://github.com/milesfrain/configs/tree/basic

### For a basic setup with most of these tmux customizations applied:

See the `basic-custom-tmux` branch:
https://github.com/milesfrain/configs/tree/basic-custom-tmux

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

You can double-check that terminal colors are configured correctly by running:
```sh
./test-24-bit-rgb-color.sh
```
This is especially useful for troubleshooting display issues in a remote tmux session.

## Usage tips:

### zsh

Some features of this configuration are:
- Fuzzy reverse history searching with `ctrl-r`.
- Fuzzy search for directories and files as arguments.
  - Add `**` to any command, followed by `<tab>`.
  - https://github.com/junegunn/fzf#files-and-directories
- Command suggestions from history.
  -  These appear in grey. Pres `ctrl-e` to accept the suggestion
- Command highlighting. Useful for catching typos before running.

### tmux

The [official tmux guide](https://github.com/tmux/tmux/wiki/Getting-Started) is extensive and covers default usage, but many of those defaults are overriden by this config's [.tmux.conf](tmux/.tmux.conf). So here in this section we summarize the most important usage notes with our customized config.

#### Prefix
The "prefix" is the key sequence that most commands start with. This config uses `ctrl-t` (and disables the inconvenient default prefix of `ctrl-b`).

For example, to create a new window, press `ctrl-t`, release, then type `c`.

#### Creating Windows and Panes
Note that "windows" contain "panes". A new window initially contains exactly one pane.

Key|Action
-|-
`c`|Create new **window**
`\`|Split **pane** vertically
`-`|Split **pane** horizontally

You can delete panes by exiting that shell with `exit` or `ctrl-d`. The window is deleted when the last pane within that window is deleted.

#### Navigating Windows and Panes

These commands are available in a prefix-free version with arrows and a VIM-style version.

Key (no prefix) | Key (with prefix) | Action
-|-|-
`alt-arrow` (left/right) | `p`/`n` | Go to previous/next **window**
| | `<number>` | Go to numbered **window**
`ctrl-arrow` | `h`/`j`/`k`/`l` | Go to neighboring **pane**
`shift-arrow` | `shift-h/j/k/l` | Resize **pane**
| | `z` | Toggle **pane** zoom

#### Other Commands

Key | Action
-|-
`?` | Show all bindings
`r` | Reload configs
`[` | Activate copy mode (freezes scrollback and allows navigation with VIM bindings). Start copy selection with `space` and finalize copy with `enter` (which also resumes scrollback).
`]` | Paste previously-copied text
`:` | Open `tmux` command prompt. Useful for stuff like (`set mouse on` and `setw synchronize-panes on`).
`d` | Detach from tmux

#### SSH Notes

Use a fresh terminal (without tmux running) to ssh into a device. That avoids problems with nested tmux sessions.

If you lose your ssh connection (for example by accidentially closing the terminal) your tmux instance will still be running on that device. You can simply reconnect over ssh and run `tmux attach` to jump back into your tmux session.

Run `tmux detach` to exit the tmux session.

#### Config Management:

You can inspect overrides to the default settings by checking `~/.tmux.conf` (linked to `tmux/.tmux.conf` via `stow`). If you change this config, you can re-apply it to a running tmux session by with prefix + `r`.
