#!/bin/bash

set -euo pipefail

# Determine the kernel version for which the NVIDIA module should be built.
KVER="$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-core | sort -V | tail -n1)"

# Install the NVIDIA akmod package and driver for the target kernel.
dnf5 install -y --enablerepo=fedora-nvidia akmod-nvidia

# Install the NVIDIA driver, libraries, utilities, and 32-bit support.
dnf5 install -y --enablerepo=fedora-nvidia \
	nvidia-driver-cuda \
	libnvidia-fbc \
	libva-nvidia-driver \
	nvidia-driver \
	nvidia-modprobe \
	nvidia-persistenced \
	nvidia-settings \
	nvidia-driver-libs.i686

# Ensure that the temporary build directory has the expected permissions.
mkdir -p /var/tmp
chmod 1777 /var/tmp
export KERNEL_MODULE_TYPE=open
akmods --force --kernels "${KVER}" --kmod nvidia
depmod -a "${KVER}"
if ! modinfo -k "${KVER}" nvidia >/dev/null 2>&1; then
	echo "NVIDIA kernel module was not installed for ${KVER}" >&2
	exit 1
fi

# Install the NVIDIA Container Toolkit from its dedicated repository.
dnf5 install -y --enablerepo=nvidia-container-toolkit nvidia-container-toolkit

# Install the SELinux policy required by the NVIDIA Container Toolkit.
curl --retry 3 -L https://raw.githubusercontent.com/NVIDIA/dgx-selinux/master/bin/RHEL9/nvidia-container.pp -o /tmp/nvidia-container.pp
semodule -i /tmp/nvidia-container.pp
rm -f /tmp/nvidia-container.pp

# Enable the service that generates the NVIDIA Container Device Interface specification.
systemctl enable nvctk-cdi.service
