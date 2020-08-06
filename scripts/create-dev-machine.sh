#!/bin/bash
set -euo pipefail

lxc init ubuntu/blkcapt "blkcaptdev" --vm
for i in {1..3}; do 
    lxc storage volume create default "blkcaptdev-disk${i}" size=1GiB --type=block
    lxc config device add "blkcaptdev" "blkcaptdev-disk${i}" disk source="blkcaptdev-disk${i}" pool=default
done

lxc start "blkcaptdev"