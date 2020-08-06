#!/bin/bash

apt-get install -y debootstrap snapd btrfs-progs dosfstools qemu-utils rsync gdisk
snap install --edge distrobuilder --classic
