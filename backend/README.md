# NexusGate - Backend

## Installation

### With docker-compose (Recommended)

Refer to README.md in project root.

**Image with `latest` tag is the latest release. If you are looking for a nightly build, use `main` tag**

### From sources

Ensure you have the latest bun installation and a production-ready PostgresSQL instance.

Edit `.env` file:

```shell
ADMIN_SUPER_SECRET=CHANGE_ME_IN_PRODUCTION
DATABASE_URL=postgres://nexusgate:your-password@databae:5432/nexusgate
```

Build from source:

```shell
cd /path/to/NexusGate/backend && \
bun install && \
NODE_ENV=production bun build src/index.ts --target bun --outdir out/
```

You will get a standalone bundle in `out/index.js`, and start server with:

```shell
NODE_ENV=production bun run out/index.js
```

Alternatively, you can bundle `index.js` with `bun` into single executable (`linux-x64-musl` for example, **NOT TESTED in other target**):

```shell
NODE_ENV=production bun build src/index.ts --target bun-linux-x64-musl --outfile out/backend --compile
```

## Contributing

NexusGate is built on Elysia.js, which depends on Bun. Ensure you have the latest bun installation.

A PostgreSQL database is required. We recommend to setup it with:

```shell
podman run -p 127.0.0.1:5432:5432 --name nexusgate-testdb -e POSTGRES_PASSWORD=password --POSTGRES_DB=testdb postgres:latest
```

Edit `.env` file:

```shell
ADMIN_SUPER_SECRET=supa_admin_secret
DATABASE_URL=postgres://postgres:password@localhost:5432/testdb
```

To start a instance of backend:

```shell
bun run dev
```

Before committing, format with biome

```shell
biome format --fix
```