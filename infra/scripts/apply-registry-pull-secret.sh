#!/usr/bin/env bash
set -euo pipefail

NS="${1:-sion2k-site}"
CRED_FILE="${CRED_FILE:-$HOME/home_robot}"

if [[ ! -f "$CRED_FILE" ]]; then
  echo "Missing credentials file: $CRED_FILE" >&2
  echo "Set CRED_FILE or create ~/home_robot with Harbor robot credentials." >&2
  exit 1
fi

USER=$(sed -n '2p' "$CRED_FILE")
PASS=$(sed -n '4p' "$CRED_FILE")

if [[ -z "$USER" || -z "$PASS" ]]; then
  echo "Could not read username/password from $CRED_FILE" >&2
  exit 1
fi

kubectl create namespace "$NS" --dry-run=client -o yaml | kubectl apply -f -
kubectl -n "$NS" create secret docker-registry registry-sion2k-pull \
  --docker-server=registry.sion2k.ru \
  --docker-username="$USER" \
  --docker-password="$PASS" \
  --dry-run=client -o yaml | kubectl apply -f -
kubectl -n "$NS" patch serviceaccount default \
  -p '{"imagePullSecrets":[{"name":"registry-sion2k-pull"}]}'

echo "Applied registry-sion2k-pull in namespace $NS"
