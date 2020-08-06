#!/bin/bash
set -euo pipefail

mkdir "${RUNNER_TEMP}/build"
mount -t tmpfs -o size=5G,nr_inodes=10000000 tmpfs "${RUNNER_TEMP}/build"

cd "${RUNNER_TEMP}/build"
distrobuilder --timeout 1500 build-dir "${GITHUB_WORKSPACE}/images/ubuntu.yaml" rootfs \
    -o image.serial="$(date +%Y%m%d).${GITHUB_RUN_NUMBER}" \
    -o image.architecture=amd64 \
    -o image.release=focal \
    -o image.variant=blkcapt \
    -o source.url=http://us.archive.ubuntu.com/ubuntu