#!/bin/bash

set -euo pipefail

echo "Cleaning up build-only packages and unused dependencies..."
dnf5 remove -y \
	akmod-nvidia \
	akmods \
	kernel-devel \
	kernel-devel-matched
dnf5 autoremove -y

# akmods' sysusers.d entry is gone with the package, drop the orphaned account too.
userdel akmods 2>/dev/null || true
groupdel akmods 2>/dev/null || true

echo "Cleaning package manager caches and temp files..."
dnf5 clean all

rm -rf /var/cache/akmods \
	/var/cache/dnf \
	/var/tmp/* \
	/tmp/* \
	/run/*
