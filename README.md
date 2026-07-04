# Tibia Platform Infrastructure

Local development infrastructure for the Tibia Guild Platform.

## Services

| Service | Image | Port |
|---------|-------|------|
| PostgreSQL 16 | `postgres:16-alpine` | 5432 |
| Redis 7 | `redis:7-alpine` | 6379 |

## Quick Start

```bash
cp .env.example .env
docker compose up -d
```

Verify services:

```bash
docker compose ps
docker compose logs -f
```

## Environment

Copy `.env.example` to `.env` and adjust values. The same variables are referenced by:

- `tibia-platform-api`
- `tibia-platform-worker`
- `tibia-platform-web`
- `tibia-discord-bot`

## Stop

```bash
docker compose down
docker compose down -v   # also remove volumes
```
