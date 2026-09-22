#!/bin/bash

set -euo pipefail

FEDORA_VERSION="$(rpm -E '%{fedora}')"

OGC_KERNEL_IMAGE="ghcr.io/opengamingcollective/kernel-packages-fedora:latest-fc${FEDORA_VERSION}"
OGC_KERNEL_DIR="$(mktemp -d)"

# Remove the downloaded artifact and temporary files when the script exits.
trap 'podman artifact rm "${OGC_KERNEL_IMAGE}" >/dev/null 2>&1 || true; rm -rf "${OGC_KERNEL_DIR}"' EXIT

# Verify that the installed Podman version supports OCI artifacts.
if ! podman artifact pull --help >/dev/null 2>&1; then
	echo "Podman 5 or newer with artifact support is required" >&2
	exit 1
fi

# Download the OGC kernel package artifact and extract its RPM files.
podman artifact pull --quiet "${OGC_KERNEL_IMAGE}"
podman artifact extract "${OGC_KERNEL_IMAGE}" "${OGC_KERNEL_DIR}"

# Remove the distribution-provided kernel packages before installing the OGC kernel.
for package in kernel kernel-core kernel-modules kernel-modules-core kernel-uki-virt kernel-devel kernel-devel-matched; do
	mapfile -t installed_packages < <(
		rpm -qa --qf '%{NAME} %{NEVRA}\n' |
			awk -v package="${package}" '$1 == package { print $2 }'
	)
	for installed_package in "${installed_packages[@]}"; do
		rpm --erase --nodeps "${installed_package}"
	done
done

# Collect the required kernel RPMs from the extracted artifact.
kernel_rpms=()
for package in kernel kernel-core kernel-modules kernel-devel kernel-devel-matched; do
	rpm_path="$(find "${OGC_KERNEL_DIR}" -maxdepth 1 -type f -name "${package}-[0-9]*.rpm" -print -quit)"
	if [[ -z "${rpm_path}" ]]; then
		echo "The OGC OCI artifact is missing ${package}" >&2
		exit 1
	fi
	kernel_rpms+=("${rpm_path}")
done

# Install the OGC kernel without pulling in optional weak dependencies.
# kernel-core's %posttrans triggers an automatic dracut regen for the new kernel here,
# which already picks up system_files/usr/lib/dracut/dracut.conf.d/99-nvidia.conf
# (copied to / before this script runs) and fails to add the nvidia module since
# it isn't installed yet (that happens in 40-nvidia.sh). Harmless: 40-nvidia.sh
# regenerates the initramfs again once the nvidia kmod exists.
dnf5 install -y --setopt=install_weak_deps=False "${kernel_rpms[@]}"
