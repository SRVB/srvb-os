#!/bin/bash

set -euo pipefail

dnf5 install -y dnf5-plugins

dnf5 install -y \
	--enablerepo=copr:copr.fedorainfracloud.org:ublue-os:packages \
	@multimedia \
	ublue-os-media-automount-udev \
	distrobox \
	fish \
	flatpak \
	fuse \
	fuse-libs \
	btrfs-progs \
	cryptsetup \
	glibc-all-langpacks \
	langpacks-de \
	langpacks-en \
	game-devices-udev \
	gnome-keyring \
	gnome-keyring-pam


chmod 0644 /usr/share/plymouth/themes/srvb/logo.png
plymouth-set-default-theme -R srvb

flatpak remote-add --if-not-exists --system flathub https://dl.flathub.org/repo/flathub.flatpakrepo
