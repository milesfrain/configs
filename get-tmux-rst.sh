#!/bin/bash

# https://unix.stackexchange.com/a/350847
if printf 'tmux 3.2a\n%s\n' "$(tmux -V)" | sort -V -C; then
    filter=(cat)
else
    filter=(
        sed -r
        -e "s/(bind-key.*\s+)([\"#~\$])(\s+)/\1\'\2\'\3/g"
        -e "s/(bind-key.*\s+)([\'])(\s+)/\1\"\2\"\3/g"
        -e "s/(bind-key.*\s+)([;])(\s+)/\1\\\\\2\3/g"
        -e "s/(command-prompt -I )#([SW])/\1\"#\2\"/g"
        -e "s/(if-shell -F -t = )#([^ ]+)/\1\"#\2\"/g"
    )
fi

tmux -f /dev/null -L temp start-server \; list-keys | \
    "${filter[@]}" > ~/.reset.tmux.conf
