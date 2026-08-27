#!/bin/bash

set -euo pipefail

dnf5 install -y \
	dnf5-plugins \
	distrobox \
	fish \
	flatpak \
	fuse \
	fuse-libs \
	bluez \
	btrfs-progs \
	cryptsetup \
	fwupd \
	glibc-all-langpacks \
	langpacks-de \
	langpacks-en \
	grub2-tools-extra \
	NetworkManager \
	pipewire \
	pipewire-pulseaudio \
	plymouth \
	plymouth-plugin-script \
	polkit \
	power-profiles-daemon \
	udisks2 \
	wireplumber \
	xdg-user-dirs

plymouth-set-default-theme -R srvb

flatpak remote-add --if-not-exists --system flathub https://dl.flathub.org/repo/flathub.flatpakrepo
