This `ansible` branch just includes a small config for `zsh`, `fzf`, and `tmux`.
It's the same as the `basic` branch, but skips the `apt update` step.
Configs are tracked using `stow`.

## Installation:

Clone the `ansible` branch of this repo and run the setup script:
```
git clone https://github.com/milesfrain/configs.git --depth=1 --branch ansible ~/configs
cd ~/configs
./setup.sh
```

You may need to manually change the default shell to `zsh` by running the following, and logging out and in:
```
chsh -s $(which zsh)
```

You can double-check that terminal colors are configured correctly by running:
```
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

This section summarizes usage with default `tmux` keybindings.

Here's a more detailed guide:
https://github.com/tmux/tmux/wiki/Getting-Started

For more opinionated tmux bindings, see the main branch:
https://github.com/milesfrain/configs

#### Prefix
The "prefix" or "leader" is the key sequence that the following commands start with. `ctrl-b` is the default.

For example, to create a new window, press `ctrl-b`, release, then type `c`.

#### Creating Windows and Panes
Note that "windows" contain "panes". A new window initially contains exactly one pane.

Key|Action
-|-
`c`|Create new **window**
`"`|Split **pane** vertically
`%`|Split **pane** horizontally

You can delete panes by exiting that shell with `exit` or `ctrl-d`. The window is deleted when the last pane within that window is deleted.

#### Navigating Windows

Key | Action
-|-
`p`/`n` | Go to previous/next window
`<number>` | Go to numbered window

#### Navigating Panes

Key | Action
-|-
`o` | Go to next pane
`q <number>` | Go to numbered pane
`<arrow>` | Go to neighboring pane
`ctrl-<arrow>` | Resize pane
`z` | Toggle pane zoom

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

Use a fresh terminal (without tmux running) into ssh to a device. That avoids problems with nested tmux sessions.

If you lose your ssh connection (for example by accidentially closing the terminal) your tmux instance will still be running on that device. You can simply reconnect over ssh and run `tmux attach` to jump back into your tmux session.

Run `tmux detach` to exit the tmux session.

#### Config Management:

You can inspect overrides to the default settings by checking `~/.tmux.conf` (linked to `tmux/.tmux.conf` via `stow`). If you change this config, you can re-apply it to a running tmux session by with prefix + `r`.
