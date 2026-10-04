#!/bin/bash

set -euo pipefail

dnf5 install -y \
	--exclude=toolbox \
	--exclude=plasma-discover \
	--exclude=plasma-discover-notifier \
	--exclude=ark \
	--exclude=konsole \
	--exclude=filelight \
	--exclude=kcharselect \
	--exclude=kwalletmanager5 \
	--exclude=kwrite \
	@kde-desktop

dnf5 install -y --enablerepo=copr:copr.fedorainfracloud.org:deltacopy:darkly darkly

systemctl enable plasmalogin.service
systemctl set-default graphical.target
