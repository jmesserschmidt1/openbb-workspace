#!/usr/bin/env bash
# Build OpenBB Lite from this repo and run it at http://localhost:3000.
#
# Needs Docker (Docker Desktop on Mac/Windows). The first build takes a while.
#
#   ./run-local.sh            build the image from local source and start it
#   ./run-local.sh --no-build start the last built image again
#   ./run-local.sh --stop     stop and remove the container (data is kept)
#
# Env overrides: PORT (default 3000), IMAGE (default openbb/lite:dev),
# NAME (container name, default openbb).
set -euo pipefail

PORT="${PORT:-3000}"
IMAGE="${IMAGE:-openbb/lite:dev}"
NAME="${NAME:-openbb}"
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

case "${1:-}" in
  --stop)
    docker rm -f "$NAME" >/dev/null 2>&1 || true
    echo "Stopped $NAME. Data is kept in the openbb-data volume."
    exit 0
    ;;
  --no-build) ;;
  "")
    IMAGE="$IMAGE" \
      BACKEND_DIR="$ROOT/backend-api" \
      WORKSPACE_DIR="$ROOT/terminalpro" \
      "$ROOT/lite/build-local.sh" --local
    ;;
  *) echo "Unknown arg: $1" >&2; exit 1 ;;
esac

docker rm -f "$NAME" >/dev/null 2>&1 || true
docker run -d -p "$PORT:3000" -v openbb-data:/data --name "$NAME" "$IMAGE" >/dev/null

echo "Starting OpenBB on http://localhost:$PORT ..."
for _ in $(seq 1 120); do
  curl -fsS "http://localhost:$PORT/api/health" >/dev/null 2>&1 && break
  sleep 1
done

docker exec "$NAME" credentials
