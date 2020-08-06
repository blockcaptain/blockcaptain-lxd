#!/bin/bash
set -euo pipefail

if lxc image info ubuntu/blkcapt &> /dev/null; then
    lxc image delete ubuntu/blkcapt
fi

TMP_DIR=$(mktemp -d)
unzip "ubuntu-vm.zip" -d "${TMP_DIR}"
lxc image import "${TMP_DIR}/lxd.tar.xz" "${TMP_DIR}/disk.qcow2" --alias ubuntu/blkcapt
rm -rf "${TMP_DIR}"
rm "ubuntu-vm.zip"