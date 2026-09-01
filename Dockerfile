# syntax=docker/dockerfile:1

FROM hugomods/hugo:0.154.5-extended AS builder

WORKDIR /src
COPY . .
RUN hugo --gc --minify

FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /src/public /app/public

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1:8080/ >/dev/null || exit 1
