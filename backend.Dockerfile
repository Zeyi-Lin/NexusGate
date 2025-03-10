FROM oven/bun:1 AS base
WORKDIR /app


FROM base AS builder
COPY . .
RUN --mount=type=cache,target=/cache \
    BUN_INSTALL_CACHE_DIR=/cache bun install --frozen-lockfile
RUN NODE_ENV=production bun build backend/src/index.ts --target bun --outdir backend/out/

FROM base AS runner 
COPY --from=builder /app/backend/out/index.js /app/index.js
COPY --from=builder /app/backend/drizzle /app/drizzle
USER bun
EXPOSE 3000/tcp
LABEL org.opencontainers.image.source="https://github.com/GeekTechX/NexusGate"
LABEL org.opencontainers.image.licenses="Apache-2.0"
ENTRYPOINT [ "bun", "run", "index.js" ]