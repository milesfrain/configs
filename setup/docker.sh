#!/usr/bin/env bash

# Docker Engine, Buildx, and Compose for Fedora and Ubuntu

set -xeuo pipefail

# shellcheck source=/dev/null
. /etc/os-release

# Also allow running directly as root or via sudo.
SUDO=()
if (( EUID != 0 )); then
  SUDO=(sudo)
fi

case "$ID" in
  fedora)
    "${SUDO[@]}" dnf install -y ca-certificates curl

    # Install the repo file directly to work with both DNF 4 and DNF 5.
    "${SUDO[@]}" curl -fsSL https://download.docker.com/linux/fedora/docker-ce.repo \
      -o /etc/yum.repos.d/docker-ce.repo

    "${SUDO[@]}" dnf install -y \
      docker-ce \
      docker-ce-cli \
      containerd.io \
      docker-buildx-plugin \
      docker-compose-plugin
    ;;
  ubuntu)
    "${SUDO[@]}" apt-get update
    "${SUDO[@]}" apt-get install -y ca-certificates curl
    "${SUDO[@]}" install -m 0755 -d /etc/apt/keyrings
    "${SUDO[@]}" curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
      -o /etc/apt/keyrings/docker.asc
    "${SUDO[@]}" chmod a+r /etc/apt/keyrings/docker.asc

    "${SUDO[@]}" tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: ${UBUNTU_CODENAME:-$VERSION_CODENAME}
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

    "${SUDO[@]}" apt-get update
    "${SUDO[@]}" apt-get install -y \
      docker-ce \
      docker-ce-cli \
      containerd.io \
      docker-buildx-plugin \
      docker-compose-plugin
    ;;
  *)
    printf 'Unsupported distribution: %s (expected Fedora or Ubuntu)\n' "$ID" >&2
    exit 1
    ;;
esac

"${SUDO[@]}" systemctl enable --now docker

user=${SUDO_USER:-$(id -un)}
if [[ "$user" != root ]]; then
  "${SUDO[@]}" usermod -aG docker "$user"
  printf 'Log out and back in to use Docker without sudo.\n'
fi

"${SUDO[@]}" docker info > /dev/null
docker compose version
docker buildx version
