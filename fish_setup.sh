# Just need to run this script once on new systems to save settings persistently.
set -U FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS --no-mouse
set -U FZF_LEGACY_KEYBINDINGS 0
set -U EDITOR nvim
# abbr -a o xdg-open # just use ctrl-g with fzf
