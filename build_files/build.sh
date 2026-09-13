#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

install -Dm644 /ctx/logo.png /usr/share/plymouth/themes/srvb/logo.png

chmod +x /usr/libexec/srvb/reset-user-config

### Install system-wide components

mapfile -t installers < <(find /ctx/install -maxdepth 1 -name '*.sh' | LC_ALL=C sort -V)
for installer in "${installers[@]}"; do
	printf 'Running %s\n' "${installer}"
	bash "${installer}"
done

systemctl enable podman.socket
