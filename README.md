# Docker CLI

[![PkgGoDev](https://pkg.go.dev/badge/github.com/docker/cli)](https://pkg.go.dev/github.com/docker/cli)
[![Build Status](https://img.shields.io/github/actions/workflow/status/docker/cli/build.yml?branch=master&label=build&logo=github)](https://github.com/docker/cli/actions?query=workflow%3Abuild)
[![Test Status](https://img.shields.io/github/actions/workflow/status/docker/cli/test.yml?branch=master&label=test&logo=github)](https://github.com/docker/cli/actions?query=workflow%3Atest)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/docker/cli/badge)](https://scorecard.dev/viewer/?uri=github.com/docker/cli)
[![Codecov](https://img.shields.io/codecov/c/github/docker/cli?logo=codecov)](https://codecov.io/gh/docker/cli)

<!-- airos-ci:latest-builds:start -->
## Latest builds

Built automatically by air/OS CI from commit `61c1ab2` on 2026-10-30 ([all files](https://github.com/airos-works/docker/releases/tag/latest)).

| Architecture | Package |
|---|---|
| arm64 | [containerd-2.4.2.git.195.932b93ed1c-1-arm64.hpkg](https://github.com/airos-works/docker/releases/download/latest/containerd-2.4.2.git.195.932b93ed1c-1-arm64.hpkg) |
| arm64 | [docker_buildx-0.38.1.git.53.6d816fc3-1-arm64.hpkg](https://github.com/airos-works/docker/releases/download/latest/docker_buildx-0.38.1.git.53.6d816fc3-1-arm64.hpkg) |
| arm64 | [docker_cli-29.10.0-1-arm64.hpkg](https://github.com/airos-works/docker/releases/download/latest/docker_cli-29.10.0-1-arm64.hpkg) |
| arm64 | [docker_engine-28.5.2.git.5765.e042e2f1315-2-arm64.hpkg](https://github.com/airos-works/docker/releases/download/latest/docker_engine-28.5.2.git.5765.e042e2f1315-2-arm64.hpkg) |
| x86_64 | [containerd-2.4.2.git.195.932b93ed1c-1-x86_64.hpkg](https://github.com/airos-works/docker/releases/download/latest/containerd-2.4.2.git.195.932b93ed1c-1-x86_64.hpkg) |
| x86_64 | [docker_buildx-0.38.1.git.53.6d816fc3-1-x86_64.hpkg](https://github.com/airos-works/docker/releases/download/latest/docker_buildx-0.38.1.git.53.6d816fc3-1-x86_64.hpkg) |
| x86_64 | [docker_cli-29.10.0-1-x86_64.hpkg](https://github.com/airos-works/docker/releases/download/latest/docker_cli-29.10.0-1-x86_64.hpkg) |
| x86_64 | [docker_engine-28.5.2.git.5765.e042e2f1315-2-x86_64.hpkg](https://github.com/airos-works/docker/releases/download/latest/docker_engine-28.5.2.git.5765.e042e2f1315-2-x86_64.hpkg) |
| x86_64 | [linuxvm-0.1.0.git.2.29d8326-1-x86_64.hpkg](https://github.com/airos-works/docker/releases/download/latest/linuxvm-0.1.0.git.2.29d8326-1-x86_64.hpkg) |

Install with `pkgman install <file>`, or copy the file into `/boot/system/packages`. Haiku SDK: x86_64 hrev60207-2122-g35b1bdfeea, arm64 hrev60207-2122-g35b1bdfeea.
<!-- airos-ci:latest-builds:end -->

## About

This repository is the home of the Docker CLI.

## Development

`docker/cli` is developed using Docker.

Build CLI from source:

```shell
docker buildx bake
```

Build binaries for all supported platforms:

```shell
docker buildx bake cross
```

Build for a specific platform:

```shell
docker buildx bake --set binary.platform=linux/arm64 
```

Build dynamic binary for glibc or musl:

```shell
USE_GLIBC=1 docker buildx bake dynbinary 
```

Run all linting:

```shell
docker buildx bake lint shellcheck
```

Run test:

```shell
docker buildx bake test
```

Run the unit test:

```
$ make -f docker.Makefile test-unit
```

Run the full test suite:

```
$ make -f docker.Makefile test
```

List all the available targets:

```shell
make help
```

### In-container development environment

Start an interactive development environment:

```shell
make shell
```

## Legal

*Brought to you courtesy of our legal counsel. For more context,
see the [NOTICE](https://github.com/docker/cli/blob/master/NOTICE) document in this repo.*

Use and transfer of Docker may be subject to certain restrictions by the
United States and other governments.

It is your responsibility to ensure that your use and/or transfer does not
violate applicable laws.

For more information, see https://www.bis.doc.gov

## Licensing

docker/cli is licensed under the Apache License, Version 2.0. See
[LICENSE](https://github.com/docker/docker/blob/master/LICENSE) for the full
license text.
