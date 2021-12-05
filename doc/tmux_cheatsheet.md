## Prefix
The "prefix" is the key sequence that most commands start with. This config uses `ctrl-t` (and disables the inconvenient default prefix of `ctrl-b`).

For example, to create a new window, press `ctrl-t`, release, then type `c`.

## Creating Windows and Panes
Note that "windows" contain "panes". A new window initially contains exactly one pane.

Key|Action
-|-
`c`|Create new **window**
`\`|Split **pane** vertically
`-`|Split **pane** horizontally

You can delete panes by exiting that shell with `exit` or `ctrl-d`. The window is deleted when the last pane within that window is deleted.

## Navigating Windows and Panes

These commands are available in a prefix-free version with arrows and a VIM-style version.

Key (no prefix) | Key (with prefix) | Action
-|-|-
`alt-arrow` (left/right) | `p`/`n` | Go to previous/next **window**
`ctrl-arrow` | `h`/`j`/`k`/`l` | Go to neighboring **pane**
`shift-arrow` | `shift-h/j/k/l` | Resize **pane**

## Other Commands

Key | Action
-|-
`[` | Activate copy mode (freezes scrollback and allows navigation with VIM bindings). Start copy selection with `space` and finalize copy with `enter` (which also resumes scrollback).
`]` | Paste previously-copied text
`?` | Show all bindings

## SSH Notes

Use a fresh terminal (without tmux running) into ssh to a device. That avoids problems with nested tmux sessions.

If you lose your ssh connection (for example by accidentially closing the terminal) your tmux instance will still be running on that device. You can simply reconnect over ssh and run `tmux attach` to jump back into your tmux session.

## Config Management:

You can inspect overrides to the default settings by checking `~/.tmux.conf` (linked to `tmux/.tmux.conf` via `stow`). If you change this config, you can re-apply it to a running tmux session by with prefix + `r`.