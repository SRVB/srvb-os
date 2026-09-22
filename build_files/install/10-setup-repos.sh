#!/bin/bash

set -euo pipefail

FEDORA_VERSION="$(rpm -E '%{fedora}')"

dnf5 -y install dnf5-plugins

dnf5 config-manager addrepo --from-repofile=https://negativo17.org/repos/fedora-nvidia.repo
dnf5 config-manager setopt fedora-nvidia.enabled=0
sed -i '/^enabled=/a\priority=90' /etc/yum.repos.d/fedora-nvidia.repo

dnf5 config-manager addrepo --from-repofile="https://copr.fedorainfracloud.org/coprs/ublue-os/packages/repo/fedora-${FEDORA_VERSION}/ublue-os-packages-fedora-${FEDORA_VERSION}.repo"
dnf5 config-manager setopt copr:copr.fedorainfracloud.org:ublue-os:packages.enabled=0

dnf5 config-manager addrepo --from-repofile="https://raw.githubusercontent.com/terrapkg/subatomic-repos/main/terra.repo"
dnf5 config-manager setopt terra.enabled=0
