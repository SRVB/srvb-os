#!/bin/bash

set -ouex pipefail

packages=(
    nvidia-driver-cuda
    libnvidia-fbc
    libva-nvidia-driver
    nvidia-driver
    nvidia-modprobe
    nvidia-persistenced
    nvidia-settings
    nvidia-driver-libs.i686
)

KVER="$(ls /usr/lib/modules | head -n1)"

dnf5 -y install dnf5-plugins
dnf5 config-manager addrepo --from-repofile=https://negativo17.org/repos/fedora-nvidia.repo
dnf5 config-manager setopt fedora-nvidia.enabled=0
sed -i '/^enabled=/a\priority=90' /etc/yum.repos.d/fedora-nvidia.repo

dnf5 -y install --enablerepo=fedora-nvidia akmod-nvidia

mkdir -p /var/tmp
chmod 1777 /var/tmp
akmods --force --kernels "${KVER}" --kmod nvidia

dnf5 -y install --enablerepo=fedora-nvidia "${packages[@]}"

dnf5 config-manager addrepo --from-repofile=https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo
dnf5 config-manager setopt nvidia-container-toolkit.enabled=0
dnf5 config-manager setopt nvidia-container-toolkit.gpgcheck=1
dnf5 -y install --enablerepo=nvidia-container-toolkit nvidia-container-toolkit

curl --retry 3 -L https://raw.githubusercontent.com/NVIDIA/dgx-selinux/master/bin/RHEL9/nvidia-container.pp -o /tmp/nvidia-container.pp
semodule -i /tmp/nvidia-container.pp
rm -f /tmp/nvidia-container.pp

systemctl enable nvctk-cdi.service