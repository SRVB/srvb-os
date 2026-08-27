#!/bin/bash

set -euo pipefail

FEDORA_VERSION="$(rpm -E '%{fedora}')"
dnf5 config-manager addrepo --from-repofile="https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland/repo/fedora-${FEDORA_VERSION}/lionheartp-Hyprland-fedora-${FEDORA_VERSION}.repo"
dnf5 config-manager setopt copr:copr.fedorainfracloud.org:lionheartp:Hyprland.enabled=0

dnf5 install -y \
	--enablerepo=copr:copr.fedorainfracloud.org:lionheartp:Hyprland \
	--exclude=wofi \
	--exclude=nwg-panel \
	greetd \
	gnome-keyring \
	gnome-keyring-pam \
	noctalia-git \
	noctalia-greeter \
	matugen \
	hyprland \
	hyprland-guiutils \
	xdg-desktop-portal \
	xdg-desktop-portal-hyprland \
	xkeyboard-config \
	adw-gtk3-theme \
	qt6ct

systemctl enable greetd.service
systemctl set-default graphical.target
