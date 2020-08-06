#!/bin/bash
set -euo pipefail

TMP_DIR=$(mktemp -d)
unzip "ubuntu-vm.zip" -d "${TMP_DIR}"
lxc image import "${TMP_DIR}/lxd.tar.xz" "${TMP_DIR}/disk.qcow2" --alias ubuntu/blkcapt
rm -rf "${TMP_DIR}"
rm "ubuntu-vm.zip"