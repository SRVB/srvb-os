#!/bin/bash

set -euo pipefail

dnf5 install -y \
	--enablerepo=terra \
	greetd \
	noctalia \
	noctalia-greeter \
	umbriel-nightly \
	xwayland-satellite \
	gnome-keyring \
	gnome-keyring-pam \
	matugen \
	adw-gtk3-theme \
	qt6ct

systemctl enable greetd.service
systemctl set-default graphical.target
