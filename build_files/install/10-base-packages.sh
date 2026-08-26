#!/bin/bash

set -euo pipefail


dnf5 install -y \
	dnf5-plugins \
	glibc-all-langpacks \
	langpacks-de \
	langpacks-en