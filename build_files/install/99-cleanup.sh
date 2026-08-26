#!/bin/bash

set -euo pipefail

echo "Cleaning up build-only packages and unused dependencies..."
dnf5 remove -y \
	akmod-nvidia \
	akmods \
	kernel-devel \
	kernel-devel-matched
dnf5 autoremove -y

echo "Cleaning package manager caches and temp files..."
dnf5 clean all

rm -rf /var/cache/akmods \
	/var/cache/dnf \
	/var/tmp/* \
	/tmp/*
