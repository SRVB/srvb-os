#!/bin/bash

set -euo pipefail

dnf5 install -y dnf5-plugins

dnf5 install -y \
	--enablerepo=copr:copr.fedorainfracloud.org:ublue-os:packages \
	@multimedia \
	ublue-os-media-automount-udev \
	ublue-os-udev-rules \
	lm_sensors \
	tuned \
	tuned-ppd \
	uresourced \
	dosfstools \
	exfatprogs \
	ntfs-3g \
	ntfsprogs \
	amd-ucode-firmware \
	distrobox \
	fish \
	fuse \
	fuse-libs \
	btrfs-progs \
	cryptsetup \
	langpacks-de \
	langpacks-en \
	plymouth \
	plymouth-plugin-script \
	gnome-keyring \
	gnome-keyring-pam

systemctl enable srvb-flatpak-preinstall.service
systemctl enable tuned.service
systemctl enable tuned-ppd.service

chmod 0644 /usr/share/plymouth/themes/srvb/logo.png
plymouth-set-default-theme -R srvb
