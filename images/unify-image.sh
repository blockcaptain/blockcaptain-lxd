#!/bin/bash
set -euo pipefail

cd "${RUNNER_TEMP}/build"

mkdir "unified"
tar xvf "lxd.tar.xz" -C "unified"
mv "disk.qcow2" "unified/rootfs.img"
tar cvf "ubuntu-vm.tar" -C "unified" .
