# Docker for air/OS

This is the air/OS (Haiku) port of the Docker CLI, maintained by the
airos-works project. Upstream is [docker/cli](https://github.com/docker/cli).

## Status

- The CLI (`./cmd/docker`) builds for `haiku/amd64` and `haiku/arm64`
  from a Linux host with the Haiku-enabled Go toolchain. There is no
  32-bit ARM (`haiku/arm`) Go toolchain yet, so ARMv7 boards (e.g. the
  Cubieboard target) cannot run the CLI until the Go port gains an
  arm backend; x86_64, ARM64 (Raspberry Pi 4, ROCK 5) and riscv64 are
  covered by the toolchain.
- The port carries its changes in `vendor/` (plus one build-tag change in
  the CLI's dependencies), so rebasing onto new upstream releases is a
  normal vendor update plus the small set of Haiku files listed below.

## Building

```sh
tools/build-haiku.sh              # build/haiku-amd64/docker, build/haiku-arm64/docker
tools/build-haiku.sh riscv64    # any arch the toolchain supports
```

`GO_HAIKU_TOOLCHAIN` overrides the toolchain path
(default `/mnt/HaikuWork/toolchains/go-haiku`, the gen2brain/go Haiku
port plus air/OS syscall extensions: `Tcgetattr`, `Tcsetattr`, `Ioctl`,
`Openat`, `Fchmodat`, `Mknodat`, `Fchownat`).

## Haiku changes

- `vendor/golang.org/x/sys/unix/haiku.go` — minimal Haiku port of
  x/sys/unix backed by the toolchain's `syscall` package (Haiku signal
  numbering, termios, winsize, device numbers, socket and `*at` calls).
  Extend this file as new symbols are needed.
- `vendor/github.com/moby/moby/client/client_{unix,haiku}.go` — the
  default daemon socket on air/OS is
  `unix:///var/run/docker.sock` (on Haiku `/var` resolves to
  `/boot/system/var`). The Engine port listens there; override with
  `DOCKER_HOST` as usual.
- `vendor/github.com/moby/sys/user/lookup_unix.go` — Haiku parses
  `/etc/passwd` like other Unixes.
- `vendor/github.com/moby/go-archive` — two casts for Haiku's signed
  `ino_t`.
- `vendor/github.com/sirupsen/logrus/terminal_check_haiku.go` — terminal
  detection through the new termios support.

## Compose

[airos-works/compose](https://github.com/airos-works/compose) ports the
`docker compose` plugin; the CLI discovers it under
`/boot/system/lib/docker/cli-plugins`, and the docker_compose package also
installs `docker-compose` in `bin/`.

## Signals

`moby/sys/signal` (vendored) has Haiku's signal table, so `docker kill -s`,
`docker stop --signal` and `docker run`'s signal proxy know signals by name
(Haiku numbers them differently from Linux: SIGUSR1 is 18; the Engine's
haiku shim translates them for containers in the Linux VM).

## Daemon

The Engine (dockerd) is ported in
[airos-works/moby](https://github.com/airos-works/moby) (the docker_engine
package). Containers from Haiku images run natively; containers from Linux
images run in air/OS's Linux VM (the linuxvm package,
[airos-works/linuxvm](https://github.com/airos-works/linuxvm)), with Linux's
namespaces, cgroups and networks. To use another Docker daemon, point the CLI
at it with `DOCKER_HOST=tcp://...`.
