#!/bin/bash
set -euo pipefail

cd "${RUNNER_TEMP}/build"
distrobuilder pack-lxd "${GITHUB_WORKSPACE}/images/ubuntu.yaml" rootfs \
    --vm \
    -o image.serial="$(date +%Y%m%d).${GITHUB_RUN_NUMBER}" \
    -o image.architecture=amd64 \
    -o image.release=focal \
    -o image.variant=blkcapt \
    -o source.url=http://us.archive.ubuntu.com/ubuntu

rm -rf "rootfs"
ls -la .
