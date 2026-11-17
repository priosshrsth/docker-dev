#!/usr/bin/env bash
# One-time Docker setup for Arch / CachyOS.
set -euo pipefail

sudo pacman -S --needed --noconfirm docker docker-compose docker-buildx
sudo systemctl enable --now docker.service

if ! id -nG "$USER" | grep -qw docker; then
  sudo usermod -aG docker "$USER"
  echo ">> Added $USER to the docker group. Log out and back in (or run 'newgrp docker')."
fi

docker --version || true
docker compose version || true
