#!/bin/bash

set -euo pipefail

os_release=/usr/lib/os-release

grep -q '^NAME=' "$os_release"
grep -q '^PRETTY_NAME=' "$os_release"

sed -i \
	-e 's/^NAME=.*/NAME="SRVB-OS"/' \
	-e 's/^PRETTY_NAME=.*/PRETTY_NAME="SRVB-OS"/' \
	"$os_release"

fedora_version="$(rpm -E %fedora)"
printf 'SRVB-OS release %s (Fedora Linux)\n' "$fedora_version" > /etc/system-release
