#!/bin/bash

set -euo pipefail

# Additional desktop applications and packages

FEDORA_VERSION="$(rpm -E '%{fedora}')"

dnf5 install -y \
	--enablerepo=terra \
	gamemode \
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

curl --retry 3 -fsSL https://starship.rs/install.sh | sh -s -- \
	--yes \
	--bin-dir /usr/local/bin

useradd -D --shell /usr/bin/fish

systemctl enable ublue-os-media-automount.service
systemctl enable podman.socket
