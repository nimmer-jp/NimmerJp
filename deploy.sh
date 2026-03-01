#!/bin/sh
set -eu

PROJECT_ID="${PROJECT_ID:-pianopia}"
SERVICE="${SERVICE:-nimmerjp}"
REGION="${REGION:-asia-northeast1}"
IMAGE="${REGION}-docker.pkg.dev/${PROJECT_ID}/${SERVICE}/${SERVICE}:latest"

[ -f .env ] && set -a && . ./.env && set +a
: "${SECRET_KEY:?Set SECRET_KEY in .env or env vars}"

gcloud config set project "$PROJECT_ID"
gcloud artifacts repositories create "$SERVICE" --repository-format=docker --location="$REGION" >/dev/null 2>&1 || true
gcloud auth configure-docker "${REGION}-docker.pkg.dev" --quiet
docker buildx build --platform linux/amd64 -t "$IMAGE" --push .
gcloud run deploy "$SERVICE" --image "$IMAGE" --region "$REGION" --platform managed --allow-unauthenticated --port 8080 --set-env-vars "SECRET_KEY=$SECRET_KEY"
