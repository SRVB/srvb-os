#!/bin/bash

set -euo pipefail

OGC_KERNEL_IMAGE="ghcr.io/opengamingcollective/kernel-packages-fedora:latest"
OGC_KERNEL_DIR="$(mktemp -d)"
trap 'podman artifact rm "${OGC_KERNEL_IMAGE}" >/dev/null 2>&1 || true; rm -rf "${OGC_KERNEL_DIR}"' EXIT

if ! podman artifact pull --help >/dev/null 2>&1; then
	echo "Podman 5 or newer with artifact support is required" >&2
	exit 1
fi

podman artifact pull --quiet "${OGC_KERNEL_IMAGE}"
podman artifact extract "${OGC_KERNEL_IMAGE}" "${OGC_KERNEL_DIR}"

for package in kernel kernel-core kernel-modules kernel-modules-core kernel-uki-virt kernel-devel kernel-devel-matched; do
	mapfile -t installed_packages < <(
		rpm -qa --qf '%{NAME} %{NEVRA}\n' \
		| awk -v package="${package}" '$1 == package { print $2 }'
	)
	for installed_package in "${installed_packages[@]}"; do
		rpm --erase --nodeps "${installed_package}"
	done
done

kernel_rpms=()
for package in kernel kernel-core kernel-modules kernel-devel kernel-devel-matched; do
	rpm_path="$(find "${OGC_KERNEL_DIR}" -maxdepth 1 -type f -name "${package}-[0-9]*.rpm" -print -quit)"
	if [[ -z "${rpm_path}" ]]; then
		echo "The OGC OCI artifact is missing ${package}" >&2
		exit 1
	fi
	kernel_rpms+=("${rpm_path}")
done

dnf5 install -y --setopt=install_weak_deps=False "${kernel_rpms[@]}"