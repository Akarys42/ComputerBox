#!/bin/bash
set -e

if [ ! -f store.qcow2 ]; then
    qemu-img create -f qcow2 -o preallocation=metadata store.qcow2 30G
fi

qemu-system-x86_64 -kernel ./vmlinuz -append "console=ttyS0 -- $@" -initrd ./initramfs.cpio.gz -nographic -drive file=store.qcow2,if=virtio,format=qcow2,id=store -device virtio-rng
