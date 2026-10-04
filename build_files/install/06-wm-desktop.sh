#!/bin/bash

set -euo pipefail

dnf5 install -y \
	--exclude=toolbox \
	--exclude=plasma-discover \
	--exclude=ark \
	--exclude=konsole \
	--exclude=filelight \
	--exclude=kcharselect \
	--exclude=kwalletmanager5 \
	--exclude=kwrite \
	@kde-desktop

systemctl enable plasmalogin.service
systemctl set-default graphical.target
