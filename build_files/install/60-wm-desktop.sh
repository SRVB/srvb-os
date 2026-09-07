#!/bin/bash

set -euo pipefail

dnf5 install -y \
	greetd \
	noctalia-git \
	noctalia-greeter \
	umbriel-nighly \
	xdg-desktop-portal \
	xdg-desktop-portal-umbriel \
	xwayland-satellite \
	gnome-keyring \
	gnome-keyring-pam \
	matugen \
	xkeyboard-config \
	adw-gtk3-theme \
	hyprqt6engine

systemctl enable greetd.service
systemctl set-default graphical.target
