#!/bin/bash
set -e

qemu-system-x86_64 -m 1G -kernel ./vmlinuz -append "console=ttyS0 -- $@" -initrd ./initramfs.cpio.gz -nographic
