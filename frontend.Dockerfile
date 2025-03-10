FROM oven/bun:1 AS builder
WORKDIR /app

COPY . .
RUN --mount=type=cache,target=/cache \
    BUN_INSTALL_CACHE_DIR=/cache bun install --frozen-lockfile
ENV NODE_ENV=production VITE_BASE_URL=/
RUN cd frontend && bun run build 

FROM nginx:alpine AS runner
COPY ./nginx-entrypoint.sh /nginx-entrypoint.sh
COPY --from=builder /app/frontend/dist/ /var/www/html/
LABEL org.opencontainers.image.source="https://github.com/GeekTechX/NexusGate"
LABEL org.opencontainers.image.licenses="Apache-2.0"
EXPOSE 80/tcp
CMD ["/bin/sh", "/nginx-entrypoint.sh"]