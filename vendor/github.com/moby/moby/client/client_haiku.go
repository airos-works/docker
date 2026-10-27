//go:build haiku

package client

import (
	"context"
	"net"
	"syscall"
)

// DefaultDockerHost defines the OS-specific default host if the DOCKER_HOST
// (EnvOverrideHost) environment variable is unset or empty.
//
// air/OS has no /var/run; the Docker Engine port for air/OS listens on a
// unix socket under /boot/system/cache (transient runtime data, writable on
// both raw images and package-managed installs).
const DefaultDockerHost = "unix:///boot/system/cache/docker/docker.sock"

// dialPipeContext connects to a Windows named pipe. It is not supported on non-Windows.
func dialPipeContext(_ context.Context, _ string) (net.Conn, error) {
	return nil, syscall.EAFNOSUPPORT
}
