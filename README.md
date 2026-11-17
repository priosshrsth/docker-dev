# docker-dev

Shared backing services (Postgres, MySQL, Redis, GCS emulator, Mailpit) for local development. The same `docker-compose.yml` runs on macOS (OrbStack) and Linux (native Docker + Caddy).

| Service       | Profile     | Linux                            | macOS (OrbStack)          |
| ------------- | ----------- | -------------------------------- | ------------------------- |
| Postgres 18 + pgvector | *(always)* | `postgres.localhost:5432` | `postgres.orb.local`      |
| MySQL 8.4     | `mysql`     | `mysql.localhost:3306`           | `mysql.orb.local`         |
| MySQL 5.6     | `mysql5`    | `mysql5.localhost:3305`          | `mysql5.orb.local`        |
| Redis 8       | `redis`     | `redis.localhost:6379`           | `redis.orb.local`         |
| Dragonfly     | `dragonfly` | `dragonfly.localhost:6380`       | `dragonfly.orb.local`     |
| GCS emulator  | `gcs`       | https://gcs.localhost            | `gcs.orb.local`           |
| Mailpit       | `mail`      | https://mail.localhost (SMTP `:1025`) | `mail.orb.local`     |

`*.localhost` always resolves to the local machine (on Linux, macOS and in browsers), so the published ports also work on the Mac.

## Setup

### Linux (Arch / CachyOS)

```sh
./scripts/setup-linux.sh          # install Docker, enable service, add docker group (re-login after)
cp .env.example .env              # keep `proxy` in COMPOSE_PROFILES
docker compose up -d
./scripts/trust-caddy-ca.sh       # once: trust Caddy's local CA for https://*.localhost
```

The `caddy` service ([caddy-docker-proxy](https://github.com/lucaslorentz/caddy-docker-proxy)) binds ports 80/443 and reads `caddy=` labels. To expose a new HTTP service, add:

```yaml
labels:
  - caddy=myapp.localhost
  - caddy.reverse_proxy={{upstreams 3000}}
```

### macOS (OrbStack)

```sh
cp .env.example .env              # remove `proxy` from COMPOSE_PROFILES
docker compose up -d
```

OrbStack reads the `dev.orbstack.domains` labels.

## Usage

```sh
docker compose up -d                          # postgres + profiles in COMPOSE_PROFILES
docker compose --profile mysql up -d          # add a service ad hoc
docker compose ps
docker compose logs -f postgres
```

Data lives in `./volumes/` (gitignored). Postgres runs any `*.sql`/`*.sh` in `volumes/postgres/init/` the first time the database is created.
