#!/bin/bash

set -euo pipefail

# Additional desktop applications and packages

FEDORA_VERSION="$(rpm -E '%{fedora}')"

dnf5 install -y \
	--enablerepo=copr:copr.fedorainfracloud.org:ublue-os:packages \
	--enablerepo=terra \
	gamemode \
	gnome-disk-utility \
	kitty \
	libFAudio \
	libFAudio.i686 \
	mangohud \
	mangohud.i686 \
	nautilus \
	openxr \
	steam \
	steam-devices \
	satty \
	gamescope \
	ublue-os-media-automount-udev \
	unzip \
	vkBasalt \
	vkBasalt.i686 \
	vulkan-tools \
	wl-clipboard

curl --retry 3 -fsSL https://starship.rs/install.sh | sh -s -- \
	--yes \
	--bin-dir /usr/local/bin

font_dir=/usr/share/fonts/FiraCode
font_archive=/tmp/FiraCode.zip
mkdir -p "${font_dir}"
curl --retry 3 -fsSL \
	-o "${font_archive}" \
	https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip -q "${font_archive}" -d "${font_dir}"
rm -f "${font_archive}"
fc-cache -f "${font_dir}"

useradd -D --shell /usr/bin/fish

systemctl enable ublue-os-media-automount.service
