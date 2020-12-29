# blockcaptain-lxd

This repository hosts GitHub Actions for building and publishing an LXD VM image. This image is useful for testing and development of BlockCaptain.

The image uses btrfs on root, unlike the standard Ubuntu images.

## Using the Image

Manually import and update with image:

```
lxc image import https://lxd.blockcaptain.dev/ubuntu-vm --alias ubuntu/blkcapt
```

Manually run a VM:

```
lxc launch ubuntu/blkcapt blkcaptdev --vm
```

For a more automated approach see [blockcaptain-eng](https://github.com/blockcaptain/blockcaptain-eng).