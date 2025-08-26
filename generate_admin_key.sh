#!/usr/bin/env bash
set -euo pipefail

docker compose exec convex-backend ./generate_admin_key.sh