#!/bin/bash
set -euo pipefail

lxc init ubuntu/blkcapt "blkcaptdev" --vm
for i in {1..3}; do 
    if lxc storage volume show default "blkcaptdev-disk${i}"; then
        lxc storage volume delete default "blkcaptdev-disk${i}"
    fi
    lxc storage volume create default "blkcaptdev-disk${i}" size=1GiB --type=block
    lxc config device add "blkcaptdev" "blkcaptdev-disk${i}" disk source="blkcaptdev-disk${i}" pool=default
done

lxc start "blkcaptdev"