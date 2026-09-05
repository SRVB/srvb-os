#!/bin/bash

set -euo pipefail

dnf5 install -y \
	@cosmic-desktop-environment \
	gnome-keyring \
	gnome-keyring-pam

#systemctl set-default graphical.target
