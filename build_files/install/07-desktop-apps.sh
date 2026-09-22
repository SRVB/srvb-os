#!/bin/bash

set -euo pipefail

# Additional desktop applications and packages

dnf5 install -y \
	--enablerepo=terra \
	gnome-disk-utility \
	libFAudio \
	libFAudio.i686 \
	mangohud \
	mangohud.i686 \
	openxr \
	steam \
	steam-devices \
	gamescope \
	unzip \
	vkBasalt \
	vkBasalt.i686 \
	vulkan-tools \
	ghostty

# Install Ghostty Shaders
shader_dir=/usr/share/srvb/ghostty/shaders
shader_archive=/tmp/ghostty-cursor-shaders.tar.gz
mkdir -p "${shader_dir}"
curl --retry 3 -fsSL \
	-o "${shader_archive}" \
	https://github.com/sahaj-b/ghostty-cursor-shaders/archive/refs/heads/main.tar.gz
tar -xzf "${shader_archive}" \
	-C "${shader_dir}" \
	--strip-components=1 \
	--wildcards '*.glsl'

# Install Starship
curl --retry 3 -fsSL https://starship.rs/install.sh | sh -s -- \
	--yes \
	--bin-dir /usr/local/bin

# Set fish as default shell
useradd -D --shell /usr/bin/fish

systemctl enable ublue-os-media-automount.service
systemctl enable podman.socket
