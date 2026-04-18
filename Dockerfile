FROM debian:bookworm-slim AS css-builder
WORKDIR /app

ARG TAILWIND_VERSION=v3.4.17
RUN apt-get update \
  && apt-get install -y --no-install-recommends curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL \
  "https://github.com/tailwindlabs/tailwindcss/releases/download/${TAILWIND_VERSION}/tailwindcss-linux-x64" \
  -o /usr/local/bin/tailwindcss \
  && chmod +x /usr/local/bin/tailwindcss

COPY tailwind.config.js ./
COPY src ./src
COPY app ./app
COPY main.nim ./main.nim
RUN mkdir -p public/css \
  && tailwindcss -c ./tailwind.config.js -i ./src/styles/tailwind.css -o ./public/css/tailwind.css --minify

FROM nimlang/nim:alpine AS nim-builder
WORKDIR /app

RUN apk add --no-cache git build-base bash

# Basolato はコンパイル時に SECRET_KEY を要求する（実行時は別値に差し替え可能）
ENV SECRET_KEY=docker-build-placeholder

RUN nimble install -y https://github.com/itsumura-h/nim-basolato

COPY scripts/patch-basolato-gcsafe.sh ./scripts/patch-basolato-gcsafe.sh
RUN chmod +x ./scripts/patch-basolato-gcsafe.sh && bash ./scripts/patch-basolato-gcsafe.sh

COPY app ./app
COPY main.nim ./
COPY config.nims ./
COPY public ./public
COPY --from=css-builder /app/public/css/tailwind.css ./public/css/tailwind.css

RUN nim c -d:release --opt:size --hints:off -o:server main.nim

FROM alpine:3.20
WORKDIR /app

RUN apk add --no-cache libstdc++ pcre

ENV HOST=0.0.0.0
ENV PORT=8080

COPY --from=nim-builder /app/server ./server
COPY --from=nim-builder /app/public ./public

EXPOSE 8080
CMD ["./server"]
