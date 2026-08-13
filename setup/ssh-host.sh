#!/usr/bin/env bash

# Setup machine as ssh host

set -xe

# Use apt by default (debian/ubuntu), or dnf for fedora
APT=apt
if command -v dnf &> /dev/null; then
    APT=dnf
fi

sudo $APT update

sudo $APT install -y \
  git \
  net-tools \
  openssh-server \
  avahi-daemon \
  avahi-utils

sudo systemctl enable --now ssh avahi-daemon
