#!/bin/bash

# Works for tmux version >= 3.2a
# Additional escaping needed for older versions.
# Can refer to earlier version of this file or linked
# code snippet.
# https://unix.stackexchange.com/a/350847
# Todo add logic to script to check for tmux version
tmux -f /dev/null -L temp start-server \; list-keys > ~/.reset.tmux.conf
