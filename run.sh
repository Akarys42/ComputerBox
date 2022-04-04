#!/bin/bash
set -e

qemu-system-x86_64 -kernel ./vmlinuz -append "console=ttyS0 -- $@" -initrd ./initramfs.cpio.gz -nographic
