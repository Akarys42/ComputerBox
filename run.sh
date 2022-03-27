#!/bin/bash
set -e

init_params=$([[ -z "$SPAWN_SHELL" ]] && echo "" || echo "binary=/bin/sh")

qemu-system-x86_64 -kernel ./vmlinuz -append "console=ttyS0 -- ${init_params}" -initrd ./initramfs.cpio.gz -nographic
