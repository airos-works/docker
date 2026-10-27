#!/usr/bin/env bash
# Cross-build the Docker CLI for air/OS (Haiku) from Linux.
#
#   tools/build-haiku.sh [arch ...]     default: amd64 arm64
#
# Uses the Haiku-enabled Go toolchain (gen2brain/go fork with the air/OS
# syscall extensions: Tcgetattr/Tcsetattr/Ioctl and the *at family).
# Binaries land in build/haiku-<arch>/docker.
set -euo pipefail

ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
cd "$ROOT"

TOOLCHAIN=${GO_HAIKU_TOOLCHAIN:-/mnt/HaikuWork/toolchains/go-haiku}
GO="$TOOLCHAIN/bin/go"
ARCHES=("$@")
[ ${#ARCHES[@]} -eq 0 ] && ARCHES=(amd64 arm64)

# docker/cli vendors its deps and deliberately ships no go.mod
# (vendor.mod instead); materialize one for the build, like
# scripts/with-go-mod.sh does.
CREATED_GOMOD=0
if [ ! -f go.mod ]; then cp vendor.mod go.mod; CREATED_GOMOD=1; fi
trap '[ "$CREATED_GOMOD" = 1 ] && rm -f go.mod || true' EXIT

for arch in "${ARCHES[@]}"; do
    out="build/haiku-$arch/docker"
    mkdir -p "$(dirname "$out")"
    echo ">> building haiku/$arch -> $out"
    GOOS=haiku GOARCH="$arch" CGO_ENABLED=0 GOFLAGS=-mod=vendor \
        "$GO" build -trimpath -ldflags="-s -w" -o "$out" ./cmd/docker
    ls -la "$out"
done
