//go:build haiku

package manager

// defaultSystemPluginDirs are the platform-specific locations to search
// for plugins in order of preference. On air/OS (Haiku), packaged plugins
// install under /boot/system/lib/docker/cli-plugins.
var defaultSystemPluginDirs = []string{
	"/boot/system/lib/docker/cli-plugins",
	"/boot/system/libexec/docker/cli-plugins",
}
