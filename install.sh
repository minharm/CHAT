#!/usr/bin/env bash
set -euo pipefail

if [ ! -f .env ]; then
  cp .env.example .env
  echo "[install] .env created from .env.example"
else
  echo "[install] .env already exists, keeping current values"
fi

docker compose pull
docker compose build backend
docker compose up -d

echo "[install] services status"
docker compose ps

echo "[install] backend logs (last 80 lines)"
docker compose logs --tail=80 backend || true
