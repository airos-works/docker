#!/usr/bin/env bash
# Build the docker CLI .hpkg(s) on Linux with the host Haiku `package` tool.
# Usage: tools/package-haiku-cross.sh [arch ...]   (default: amd64 arm64)
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
cd "$ROOT"

PACKAGE_TOOL=${PACKAGE_TOOL:-/mnt/HaikuWork/x399/build/x86_64/objects/linux/x86_64/release/tools/package/package}
VERSION=$(tr -d ' \n' < VERSION)
BASE=${BASE:-docker_cli}
STAGE=$(mktemp -d /tmp/docker-pkg-XXXXXX)
trap 'rm -rf -- "$STAGE"' EXIT
mkdir -p "$ROOT/artifacts" "$STAGE/bin" "$STAGE/documentation/packages/docker_cli"

for arch in "${@:-amd64 arm64}"; do
    haiku_arch=$arch
    [ "$arch" = "amd64" ] && haiku_arch=x86_64
    bin="build/haiku-$arch/docker"
    if [ ! -f "$bin" ]; then
        echo ">> building $arch first"
        GO_HAIKU_TOOLCHAIN=${GO_HAIKU_TOOLCHAIN:-/mnt/HaikuWork/toolchains/go-haiku} \
            bash tools/build-haiku.sh "$arch"
    fi
    rm -rf "$STAGE/bin/docker" "$STAGE/.PackageInfo"
    cp "$bin" "$STAGE/bin/docker"
    # stripped at link time with -ldflags="-s -w"
    cp README.md docs/airos.md "$STAGE/documentation/packages/docker_cli/"
    cat > "$STAGE/.PackageInfo" <<EOF
name docker_cli
version $VERSION-1
architecture $haiku_arch
summary "Docker CLI for air/OS"
description "The docker command-line client for air/OS, ported from Docker's open-source CLI. Talks to any Docker Engine over its unix socket or TCP; on air/OS the Engine listens on unix:///var/run/docker.sock by default."
packager "air/OS contributors"
vendor "air/OS"
copyrights { "2026 air/OS contributors" "2013-2026 Docker, Inc." }
licenses { "Apache v2" }
provides {
    docker_cli = $VERSION
    cmd:docker = $VERSION
}
requires {
    haiku >= r1~beta5
}
EOF
    out="$ROOT/artifacts/${BASE}-${VERSION}-1-${haiku_arch}.hpkg"
    "$PACKAGE_TOOL" create -C "$STAGE" "$out"
    echo ">> $out"
done
