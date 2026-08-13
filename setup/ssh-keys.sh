#!/usr/bin/env bash

# Setup machine as ssh host

set -xe

ssh-keygen -t ed25519
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub

echo "Paste key here:"
echo https://github.com/settings/keys
echo https://gitlab.com/-/user_settings/ssh_keys

