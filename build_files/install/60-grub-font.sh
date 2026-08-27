#!/bin/bash

set -euo pipefail

dnf5 install -y grub2-tools

font_path="$(find /usr/share/fonts/FiraCode -type f -name 'FiraCodeNerdFont-Regular.ttf' -print -quit)"
if [[ -z "${font_path}" ]]; then
	echo "FiraCode Nerd Font Regular was not installed" >&2
	exit 1
fi

install -d /boot/grub2/fonts
grub2-mkfont -s 24 -o /boot/grub2/fonts/FiraCodeNerdFont.pf2 "${font_path}"

sed -i '/^GRUB_FONT=/d' /etc/default/grub
echo 'GRUB_FONT=/boot/grub2/fonts/FiraCodeNerdFont.pf2' >> /etc/default/grub