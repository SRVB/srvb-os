#!/bin/bash

set -euo pipefail

# Additional desktop applications and packages

dnf install -y \
	--enablerepo=terra \
	steam \
	steam-devices \
	libFAudio \
	libFAudio.i686 \
	gstreamer1-vaapi \
	mangohud \
	mangohud.i686 \
	mesa-dri-drivers.i686 \
	mesa-vulkan-drivers.i686 \
	openxr \
	gamescope \
	unzip \
	vkBasalt \
	vkBasalt.i686 \
	vulkan-tools \
	vulkan-loader.i686 \
	ghostty

# Install Starship
curl --retry 3 -fsSL https://starship.rs/install.sh | sh -s -- \
	--yes \
	--bin-dir /usr/local/bin

# Set fish as default shell
useradd -D --shell /usr/bin/fish

systemctl enable ublue-os-media-automount.service
systemctl enable podman.socket
