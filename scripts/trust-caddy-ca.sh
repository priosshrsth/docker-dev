#!/usr/bin/env bash
# Trust Caddy's local CA so https://*.localhost has no certificate warnings.
# Run once after the `caddy` container has started (it creates the CA on first boot).
set -euo pipefail
cd "$(dirname "$0")/.."

crt=volumes/caddy/caddy/pki/authorities/local/root.crt
for _ in $(seq 1 30); do
  sudo test -f "$crt" && break
  sleep 1
done
sudo test -f "$crt" || { echo "CA not found at $crt. Is the caddy container running?" >&2; exit 1; }

tmp=$(mktemp --suffix=.crt)
sudo cat "$crt" > "$tmp"
# System store (p11-kit). Arch's Firefox/Chromium read it through p11-kit too.
sudo trust anchor --store "$tmp"
rm -f "$tmp"
echo ">> Caddy local CA trusted. Restart your browser."
